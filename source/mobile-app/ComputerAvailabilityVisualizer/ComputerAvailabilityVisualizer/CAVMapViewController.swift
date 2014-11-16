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
    public let mapView:MKMapView = MKMapView()
    
    private let latitude = 41.115
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
        
        self.locationManager.requestAlwaysAuthorization()
        self.mapView = mapView;
        
        self.mapView.delegate = self
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(self.latitudeDelta, self.longitudeDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
        
        self.mapView.mapType = MKMapType.Satellite;
        mapView.setRegion(theRegion, animated: true)
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.locationManager.requestAlwaysAuthorization()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
