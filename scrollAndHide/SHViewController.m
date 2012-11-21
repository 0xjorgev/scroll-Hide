//
//  SHViewController.m
//  scrollAndHide
//
//  Created by Jorge Mendoza on 11/20/12.
//  Copyright (c) 2012 Jorge Mendoza. All rights reserved.
//

/* ---------------------------------------------------------------------------------+
 
 The MIT License (MIT)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 Description:
 This project was built to create a view with a menu just like the new FB iOS app.
 
 Developed by:
 
 Eng. Jorge V Mendoza you can contact me on twitter @jorgevmendoza
 
 +--------------------------------------------------------------------------------*/

#import "SHViewController.h"

@interface SHViewController ()
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*)tableView:(UITableView *)tableView
       cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"myCell";
    UITableViewCell * myCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(myCell ==nil)
        
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    else
        myCell.textLabel.text =
        [NSString stringWithFormat:@"%i",indexPath.row ];
    
    
    return myCell;
}

-(int)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(void)scrollViewDidScroll:(UITableView *)tableView
{
    if (!tableView.isDragging && !tableView.isDecelerating)
        [self animateScroll:NO];
    else
        [self animateScroll:YES];
}

-(void)scrollViewDidEndDecelerating:(UITableView *)tableView
{
    [self animateScroll:NO];
}

-(void)animateScroll:(BOOL)scroll
{
    
    if(scroll)
        [UIView animateWithDuration:0.5f animations:^(void){
            
            //hiden
            _toolbar.frame = CGRectMake(0, -44, _toolbar.frame.size.width,
                                        _toolbar.frame.size.height);
            
            _tabBar.frame = CGRectMake(0, self.view.frame.size.height +
                                       _tabBar.frame.size.height,
                                       _tabBar.frame.size.width,
                                       _tabBar.frame.size.height);
            
            _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width,
                                          self.view.frame.size.height);
        }];
    else
        [UIView animateWithDuration:0.8f animations:^(void){
            
            //not hiden
            _toolbar.frame = CGRectMake(0, 0, _toolbar.frame.size.width,
                                        _toolbar.frame.size.height);
            
            _tabBar.frame = CGRectMake(0, self.view.frame.size.height -
                                       _tabBar.frame.size.height,
                                       _tabBar.frame.size.width,
                                       _tabBar.frame.size.height);
            
            _tableView.frame = CGRectMake(0, _toolbar.frame.size.height,
                                          self.view.frame.size.width,
                                          self.view.frame.size.height -
                                          (_toolbar.frame.size.height
                                           + _tabBar.frame.size.height));
        }];
}

@end
