//
//  ViewController.h
//  BackgroundFetchExample
//
//  Created by Manju Sj on 5/16/16.
//  Copyright (c) 2016 Manju Sj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *bTableView;
@property (nonatomic, weak) NSArray *allNewsItems;
@property (nonatomic, unsafe_unretained) BOOL mustReloadView;


@end

