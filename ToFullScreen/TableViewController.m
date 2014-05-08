//
//  TableViewController.m
//  点击cell上的图片，放大到全屏
//
//  Created by 孙伟亮 on 14-5-8.
//  Copyright (c) 2014年 孙伟亮. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController (){
    
    
    CGRect frame_first;
    
    UIImageView *fullImageView;
    
}




@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    self.tableView.delegate=self;
    
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(100, 5, 30, 30)];
        
        imageView.tag=9999;
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)]];
        
        
        
        [cell.contentView addSubview:imageView];
        
        
    }
    
    UIImageView *image=(UIImageView *)[cell.contentView viewWithTag:9999];
     image.userInteractionEnabled=YES;
    
    image.image=[UIImage imageNamed:@"1.png"];
    
    
    
    
    return cell;
}




-(void)actionTap:(UITapGestureRecognizer *)sender{
    
    
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath  = [self.tableView indexPathForRowAtPoint:location];
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView  cellForRowAtIndexPath:indexPath];
    
    
//     NSLog(@"%f",self.tableView.contentOffset.y);
//    
//    
//    NSLog(@"%f----%f-----%f-----%f",cell.frame.origin.x,cell.frame.origin.y-self.tableView.contentOffset.y,cell.frame.size.height,cell.frame.size.width);
//    
//    

    
    UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:9999];
    
    
    frame_first=CGRectMake(cell.frame.origin.x+imageView.frame.origin.x, cell.frame.origin.y+imageView.frame.origin.y-self.tableView.contentOffset.y, imageView.frame.size.width, imageView.frame.size.height);
    
    
    
    
    
    
    
    fullImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    fullImageView.backgroundColor=[UIColor blackColor];
    fullImageView.userInteractionEnabled=YES;
    [fullImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap2:)]];
    fullImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    
    
    if (![fullImageView superview]) {
        
        fullImageView.image=imageView.image;
        
        [self.view.window addSubview:fullImageView];
    
        
        
        fullImageView.frame=frame_first;
        [UIView animateWithDuration:0.5 animations:^{
            
            fullImageView.frame=CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height);
            
            
        } completion:^(BOOL finished) {
            
            [UIApplication sharedApplication].statusBarHidden=YES;
            
        }];

        
        
    }
    
    
    
    
    
    
    
}




-(void)actionTap2:(UITapGestureRecognizer *)sender{




    [UIView animateWithDuration:0.5 animations:^{
        
        fullImageView.frame=frame_first;
        
        
    } completion:^(BOOL finished) {
        
        [fullImageView removeFromSuperview];
        

    }];
    
    
  [UIApplication sharedApplication].statusBarHidden=NO;


}







@end
