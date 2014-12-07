//
//  CAVLabDetailsViewController.swift
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 11/2/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

import UIKit

class CAVLabDetailsViewController: UIViewController {
    @IBOutlet weak var backButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        var currentLab:CAVLab
        
        let cavStoreManager = CAVStoreManager.getSharedStoreManager() as? CAVStoreManager;
        
        let entityDescription = NSEntityDescription.entityForName("CAVLab", inManagedObjectContext: cavStoreManager!.managedObjectContext)
        let request = NSFetchRequest();
        
        let sharedResources = CAVSharedResources.getSharedResources() as CAVSharedResources
        let searchForLabPredicate = NSPredicate(format: "labStatsCode == %@", sharedResources.currentDetailViewLabStatsCode)
        
        request.entity = entityDescription
        request.predicate = searchForLabPredicate
        
        let error1 = NSErrorPointer();
        let searchForLabResult = cavStoreManager?.managedObjectContext.executeFetchRequest(request, error: error1) as? [CAVLab]
    
        if(searchForLabResult == nil){
            /* Error occurred */
        }
        else{
            currentLab = searchForLabResult![0]
            println("\(currentLab.building)")
        }
    }

    @IBAction func barButtonTapped(sender: AnyObject) {
        let sharedResources = CAVSharedResources.getSharedResources() as CAVSharedResources
        sharedResources.currentDetailViewLabStatsCode = nil
        self.dismissViewControllerAnimated(true, completion: nil)
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
