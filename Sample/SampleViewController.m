//
//  SampleViewController.m
//  Sample
//
//  Created by Tarun on 07/11/15.
//  Copyright (c) 2015 nichepro. All rights reserved.
//

#import "SampleViewController.h"
#import "Case.h"

@interface SampleViewController ()
// HTTP Request
@property (nonatomic, strong) NSMutableData *responseData;
// HTTP Request
@end

@implementation SampleViewController

@synthesize mobile, messageLabel;
//Table View
@synthesize casesTableView, cases, caseDetailViewController;
//Table View

// HTTP Request
@synthesize responseData = _responseData;
// HTTP Request


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.cases = [[NSMutableArray alloc] init];
    //self.casesTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dice.png"]];
    
    self.casesTableView.backgroundColor = [UIColor clearColor];
    
    for (int i = 1; i<= 10; i++) {
        Case *newcase = [[Case alloc] init];
        newcase.title = [NSString stringWithFormat:@"Name %d", i];
        newcase.description = [NSString stringWithFormat:@"Description of %d", i];
        [self.cases addObject:newcase];
    }
    [self.casesTableView reloadData];
    
    
    // HTTP Request
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://localhost:3000/api/v1/swagger_doc"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    // HTTP Request
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sendOtpClicked:(id)sender
{
    messageLabel.text = [NSString stringWithFormat:@"OTP sent to mobile %@", mobile.text];
}

// Table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cases count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString *uniqueIdentifier = @"UITableViewCell";
    cell = [self.casesTableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
    Case *activeCase = [self.cases objectAtIndex:[indexPath row]];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:uniqueIdentifier];
        [[cell textLabel] setText: activeCase.title];
        [[cell imageView] setImage:[UIImage imageNamed:@"dice.png"]];
        [[cell detailTextLabel] setText:@"UI Table description"];
        [[cell textLabel] setTextColor: [UIColor blackColor]];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gradient.jpeg"]];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"grass.png"]];
        cell.accessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    return cell;
}
// Table View

// Navigation

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"I am in didSelectRowAtIndexPath");
    if(!self.caseDetailViewController)
    {
        self.caseDetailViewController = [[CaseDetailController alloc] init];
    }
    
    Case *selectedCase = [self.cases objectAtIndex:[indexPath row]];
    self.caseDetailViewController.selectedCase = selectedCase;
    [self.navigationController pushViewController:self.caseDetailViewController animated:YES];
}

//Navigation



// HTTP Request
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    NSLog(@"%@", [res allKeys]);
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    // extract specific value...
    NSArray *results = [res objectForKey:@"results"];
    
    for (NSDictionary *result in results) {
        NSString *icon = [result objectForKey:@"icon"];
        NSLog(@"icon: %@", icon);
    }
    
}
// HTTP Request

@end
