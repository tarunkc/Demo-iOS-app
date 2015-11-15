//
//  Case.h
//  Sample
//
//  Created by Tarun on 10/11/15.
//  Copyright (c) 2015 nichepro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Case : NSObject
{
    NSString *title;
    NSString *description;
}
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@end
