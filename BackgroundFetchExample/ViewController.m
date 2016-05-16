//
//  ViewController.m
//  BackgroundFetchExample
//
//  Created by Manju Sj on 5/16/16.
//  Copyright (c) 2016 Manju Sj. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "NewsItem.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize bTableView,allNewsItems,mustReloadView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    bTableView =[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    bTableView.delegate=self;
    bTableView.dataSource=self;
    [self.bTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:bTableView];
    AppDelegate *appdelegate=[UIApplication sharedApplication].delegate;
    self.allNewsItems=appdelegate.allNewsItems;
    [appdelegate addObserver:self forKeyPath:@"allNewsItems" options:NSKeyValueObservingOptionNew context:NULL]
    ;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleAppIsBroughtToForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    
}
- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context{
    if ([keyPath isEqualToString:@"allNewsItems"]){
        if ([self isBeingPresented]){
            [self.bTableView reloadData];
        } else {
            self.mustReloadView = YES;
        }
    }
}
- (void) handleAppIsBroughtToForeground:(NSNotification *)paramNotification{
    if (self.mustReloadView){
        self.mustReloadView = NO;
        [self.bTableView reloadData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.allNewsItems.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier
                             forIndexPath:indexPath];
    
    NewsItem *newsItem = self.allNewsItems[indexPath.row];
    cell.textLabel.text = newsItem.text;
    return cell;
}
- (void) dealloc{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate removeObserver:self forKeyPath:@"allNewsItems"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
