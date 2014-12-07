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
    
    @IBOutlet weak var mapView: MKMapView!
    //public let mapView:MKMapView = MKMapView()
    
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
        
        self.mapView = mapView;
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.locationManager.requestAlwaysAuthorization()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        
        self.mapView.delegate = self
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(self.latitudeDelta, self.longitudeDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
        
        self.mapView.removeAnnotations(self.labAnnotations)
        self.labAnnotations?.removeAll(keepCapacity: false)
        
        let sharedDownloadManager: AnyObject! = CAVDownloadManager.getSharedDownloadManager()
        var labs:[AnyObject]! = sharedDownloadManager!.retrieveLabInformation()
        
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
            
            mapView.addAnnotation(annotation)
            self.labAnnotations.append(annotation)
        }
        
        self.mapView.mapType = MKMapType.Satellite;
        mapView.setRegion(theRegion, animated: true)
        // Do any additional setup after loading the view.
    }
    
    public override func viewWillAppear(animated: Bool) {
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
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? ZSPinAnnotation
        
        if pinView == nil {
            pinView = ZSPinAnnotation(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.annotationType = ZSPinAnnotationTypeStandard
            pinView!.canShowCallout = true
            pinView!.annotationColor = self.computePinColor(cavAnnotation.numItems)
            pinView!.draggable = false
        } else {
            pinView!.annotation = annotation
        }
        
        var imageView = UIImageView(frame: CGRectMake(0,0,50,50))
        var image = UIImage()
        
        /*
        var buttonImage = UIImage(named: "arrow.gif")
        
        imageView.image = image
        
        var button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 25, 25)
        button .setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        button.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        */
        
        pinView!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIButton
        pinView!.leftCalloutAccessoryView = imageView
        
        return pinView
    }
    
    public func computePinColor(availability:NSInteger) -> UIColor{
        var color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        if availability <= 0 {
            color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        }
        else if availability <= 5{
            color = UIColor(red: 253.0 / 255.0, green: 23.0 / 255.0, blue: 0.0, alpha: 1.0)
        }
        else if availability > 5 && availability <= 10{
            color = UIColor(red: 255.0 / 255.0, green: 254.0 / 255.0, blue: 8.0 / 255.0, alpha: 1.0)
        }
        else{
            color = UIColor(red: 13.0 / 255.0, green: 255.0 / 255.0, blue: 73.0 / 255.0, alpha: 1.0)
        }
        
        return color
    }
    
    public func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == annotationView.rightCalloutAccessoryView {
            
            /*
            let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("testID") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
            */

            var annotation = annotationView.annotation as? CAVPointAnnotation;
            let sharedResources = CAVSharedResources.getSharedResources() as CAVSharedResources
            sharedResources.currentDetailViewLabStatsCode = annotation?.labStatsCode
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
