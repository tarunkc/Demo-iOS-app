//
//  SampleViewController.h
//  Sample
//
//  Created by Tarun on 07/11/15.
//  Copyright (c) 2015 nichepro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Case.h"
#import "CaseDetailController.h"

@interface SampleViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITextField *mobile;
    IBOutlet UILabel *messageLabel;

    // Table View
    IBOutlet UITableView *casesTableView;
    NSMutableArray *cases;
    // Table View
    
}
@property (nonatomic, retain) IBOutlet UITextField *mobile;
@property (nonatomic, retain) IBOutlet UILabel *messageLabel;

-(IBAction)sendOtpClicked:(id)sender;

//Table View
@property (nonatomic, retain) IBOutlet UITableView *casesTableView;
@property (nonatomic, retain) NSMutableArray *cases;
//Table View

// Navigation
@property (nonatomic, strong) CaseDetailController *caseDetailViewController;

// Navigation

@end
