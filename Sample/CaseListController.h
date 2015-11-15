//
//  CaseListController.h
//  Sample
//
//  Created by Tarun on 10/11/15.
//  Copyright (c) 2015 nichepro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseListController : NSObject
{
    IBOutlet UITableView *casesTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *casesTableView;

@end
