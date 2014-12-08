//
//  CAVMapViewController.swift
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 11/2/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

import UIKit
import MapKit

public class CAVMapViewController: UIViewController, MKMapViewDelegate {
    public let locationManager:CLLocationManager = CLLocationManager()
    private var labAnnotations: [AnyObject]! = [AnyObject]();
    private var timer: NSTimer = NSTimer();
    private var particleEmitterIsOpen = true;
    private var isMapCurrentlyUpdating = false;
    private var reachability:Reachability = Reachability.reachabilityForInternetConnection();
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var particleView: CAVSceneView!
    
    private let latitude = 41.118
    private let longitude = -85.109528
    private let latitudeDelta = 0.0015
    private let longitudeDelta = 0.0015
    
    required public init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override public init(){
        super.init()
    }
    
    public init(mapView: MKMapView){
        super.init()
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override public func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        updateParticleEmitterView()
    }
    
    private func updateMapAnnotations(){
        let sharedDownloadManager: AnyObject! = CAVDownloadManager.getSharedDownloadManager()
        var labs:[AnyObject]! = sharedDownloadManager!.labInfoList
        
        var c = 0
        var size = labs.count
        for ; c < size ; c++ {
            let lab = labs[c] as CAVLab
            
            var coord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lab.latitude.doubleValue, lab.longitude.doubleValue);
            let annotation = CAVPointAnnotation()
            annotation.coordinate = coord
            annotation.title = "\(lab.building) \(lab.room)"
            annotation.type = ZSPinAnnotationTypeStandard
            
            annotation.subtitle = "Computers Open: \(lab.numAvailCapacity)"
            annotation.numItems = lab.numAvailCapacity.integerValue
            annotation.labStatsCode = lab.labStatsCode
            
            self.mapView.addAnnotation(annotation)
            self.labAnnotations.append(annotation)
            
            self.mapView.setNeedsDisplay()
        }
    }
    
    override public func viewDidLoad() {
        self.locationManager.requestAlwaysAuthorization()
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reachabilityStatusChanged:"), name:kReachabilityChangedNotification , object: nil)
        self.reachability.startNotifier()
        
        
        mapView.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        
        mapView.delegate = self
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(self.latitudeDelta, self.longitudeDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
        
        mapView.removeAnnotations(self.labAnnotations)
        self.labAnnotations?.removeAll(keepCapacity: false)
        
        let sharedDownloadManager: AnyObject! = CAVDownloadManager.getSharedDownloadManager()
        sharedDownloadManager!.updateLabInformation()
        updateMapAnnotations()
        
        mapView.mapType = MKMapType.Satellite;
        mapView.setRegion(theRegion, animated: true)
        // Do any additional setup after loading the view.
    }
    
    func reachabilityStatusChanged(notification:NSNotification)
    {
        setUpdateTimerBasedOnReachability()
    }
    
    private func createParticleEmitterScene() -> SKScene{
        let currentScene = SKScene(size: self.particleView.bounds.size)
        currentScene.scaleMode = SKSceneScaleMode.AspectFill
        
        let interfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        if(interfaceOrientation == UIInterfaceOrientation.Portrait || interfaceOrientation == UIInterfaceOrientation.PortraitUpsideDown){
            var path:NSString = NSBundle.mainBundle().pathForResource("CAVPinParticleEmitterFull", ofType: "sks")!
            NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            var node =  NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? SKEmitterNode
            var point = CGPointMake(55.0,  35.0)
            node?.position = point
            currentScene.addChild(node!)
        
            path = NSBundle.mainBundle().pathForResource("CAVPinParticleEmitterBusy", ofType: "sks")!
            NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            node =  NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? SKEmitterNode
            point = CGPointMake(215.0,  35.0)
            node?.position = point
            currentScene.addChild(node!)
        
            path = NSBundle.mainBundle().pathForResource("CAVPinParticleEmitterCrowded", ofType: "sks")!
            NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            node =  NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? SKEmitterNode
            point = CGPointMake(390.0,  35.0)
            node?.position = point
            currentScene.addChild(node!)
        
            path = NSBundle.mainBundle().pathForResource("CAVPinParticleEmitterAvail", ofType: "sks")!
            NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            node =  NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? SKEmitterNode
            point = CGPointMake(585.0,  35.0)
            node?.position = point
            currentScene.addChild(node!)
        }
        else if(interfaceOrientation == UIInterfaceOrientation.LandscapeLeft || interfaceOrientation == UIInterfaceOrientation.LandscapeRight){
            var path:NSString = NSBundle.mainBundle().pathForResource("CAVPinParticleEmitterFull", ofType: "sks")!
            NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            var node =  NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? SKEmitterNode
            var point = CGPointMake(180.0,  35.0)
            node?.position = point
            currentScene.addChild(node!)
            
            path = NSBundle.mainBundle().pathForResource("CAVPinParticleEmitterBusy", ofType: "sks")!
            NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            node =  NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? SKEmitterNode
            point = CGPointMake(340.0,  35.0)
            node?.position = point
            currentScene.addChild(node!)
            
            path = NSBundle.mainBundle().pathForResource("CAVPinParticleEmitterCrowded", ofType: "sks")!
            NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            node =  NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? SKEmitterNode
            point = CGPointMake(520.0,  35.0)
            node?.position = point
            currentScene.addChild(node!)
            
            path = NSBundle.mainBundle().pathForResource("CAVPinParticleEmitterAvail", ofType: "sks")!
            NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            node =  NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? SKEmitterNode
            point = CGPointMake(715.0,  35.0)
            node?.position = point
            currentScene.addChild(node!)
        }
        
        currentScene.backgroundColor = UIColor.clearColor()
        currentScene.userInteractionEnabled = true
        
        return currentScene
    }
    
    
    public func mapViewWillStartRenderingMap(mapView: MKMapView!) {
            updateParticleEmitterView()
    }
    
    private func updateParticleEmitterView(){
        let scene = createParticleEmitterScene()
        self.particleView.userInteractionEnabled = true
        self.particleView.allowsTransparency = true
        self.particleView.presentScene(scene)
        self.particleView.setNeedsDisplay()
    }
    
    private func setUpdateTimerBasedOnReachability(){
        var onlineStatus:NetworkStatus = self.reachability.currentReachabilityStatus()
        if(onlineStatus.value == 0){
            self.timer.invalidate()
        }
        else{
            self.timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("updateMap"), userInfo: nil, repeats: true)
        }
    }
    
    public override func viewWillAppear(animated: Bool) {
        setUpdateTimerBasedOnReachability()
    }
    
    public override func viewWillDisappear(animated: Bool) {
        self.timer.invalidate()
    }
    
    func updateMap() {
        if(!self.isMapCurrentlyUpdating){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),{
                self.isMapCurrentlyUpdating = true;
                let sharedDownloadManager: AnyObject! = CAVDownloadManager.getSharedDownloadManager()
                sharedDownloadManager!.updateLabInformation()
                dispatch_async(dispatch_get_main_queue(),{
                    self.updateMapAnnotations()
                    self.isMapCurrentlyUpdating = false;
                })
            })
        }
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is MKUserLocation {
            return nil
        }
        
        let cavAnnotation = annotation as CAVPointAnnotation
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? CAVPointAnnotationView
        
        if pinView == nil {
            pinView = CAVPointAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.annotationType = ZSPinAnnotationTypeStandard
            pinView!.canShowCallout = true
            pinView!.annotationColor = self.computePinColor(cavAnnotation.numItems)
            pinView!.draggable = false
        } else {
            pinView!.annotation = annotation
        }
        
        var imageView = UIImageView(frame: CGRectMake(0,0,50,50))
        var image = UIImage(named: "IPFW.png")
        imageView.image = image
        
        var buttonImage = UIImage(named: "arrow.gif")
        
        var button   = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
        
        button.frame = CGRectMake(100, 100, 25, 25)
        button .setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        
        pinView!.rightCalloutAccessoryView = button
        pinView!.leftCalloutAccessoryView = imageView
        
        return pinView
    }
    
    public func computePinColor(availability:NSInteger) -> UIColor{
        var color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0) // Gray
        
        if availability <= 0 {
            color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0) // Gray
        }
        else if availability <= 5{
            color = UIColor(red: 253.0 / 255.0, green: 23.0 / 255.0, blue: 0.0, alpha: 1.0) // Red
        }
        else if availability > 5 && availability <= 10{
            color = UIColor(red: 255.0 / 255.0, green: 254.0 / 255.0, blue: 8.0 / 255.0, alpha: 1.0) // Yellow
        }
        else{
            color = UIColor(red: 13.0 / 255.0, green: 255.0 / 255.0, blue: 73.0 / 255.0, alpha: 1.0) // Green
        }
        
        return color
    }
    
    public func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == annotationView.rightCalloutAccessoryView {
            var annotation = annotationView.annotation as? CAVPointAnnotation;
            let sharedResources = CAVSharedResources.getSharedResources() as CAVSharedResources
            sharedResources.currentDetailViewLabStatsCode = annotation?.labStatsCode
            
            let labLat = annotation?.coordinate.latitude
            let labLong = annotation?.coordinate.longitude
            let labAnnLoc = CLLocation(latitude: labLat!, longitude: labLong!)
            
            let userAnn = self.mapView.userLocation
            let userLat = userAnn?.coordinate.latitude
            let userLong = userAnn?.coordinate.longitude
            let userAnnLoc = CLLocation(latitude: userLat!, longitude: userLong!)
            
           sharedResources.currentDistanceToLab = labAnnLoc.distanceFromLocation(userAnnLoc);
            self.performSegueWithIdentifier("showDetails", sender: self)
        }
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showDetails") {
            //pass the data to the next view
        }
    }
    
    public override func viewDidAppear(animated: Bool) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
