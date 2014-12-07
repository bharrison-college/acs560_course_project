//
//  CAVSceneViewController.m
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 11/2/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

#import "CAVSceneViewController.h"
#define DEFAULT_LATITUDE 41.117626;
#define DEFAULT_LONGITUDE -85.108917;
#define DEFAULT_SPAN_VALUE .004f;

@interface CAVSceneViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet GLKView *sceneView;
@property (weak, nonatomic) IBOutlet UIView *interactivityView;

@property (strong, nonatomic)CAVMapViewController *mapViewController;
@property (strong, nonatomic)CAVInteractionLayerViewController *interactivityViewController;

@end

@implementation CAVSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mapViewController = [[CAVMapViewController alloc] initWithMapView:self.mapView];

    //_interactivityViewController = [[CAVInteractionLayerViewController alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    CAVDownloadManager *downloadManager = [CAVDownloadManager getSharedDownloadManager];
    [downloadManager updateLabInformation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
