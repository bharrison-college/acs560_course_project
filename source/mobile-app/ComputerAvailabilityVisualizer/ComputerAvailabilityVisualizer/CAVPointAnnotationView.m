//
//  CAVPointAnnotationView.m
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 12/8/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

#import "CAVPointAnnotationView.h"

@interface CAVPointAnnotationView()
@end

@implementation CAVPointAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
    }
    
    return self;
}

@end
