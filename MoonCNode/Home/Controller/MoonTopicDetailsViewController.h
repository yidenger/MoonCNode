//
//  MoonTopicDetailsViewController.h
//  MoonCNode
//
//  Created by seth on 16/6/9.
//  Copyright © 2016年 seth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoonTopicModel.h"
@interface MoonTopicDetailsViewController : UITableViewController
@property(nonatomic, strong)MoonTopicModel *topic;
@property(nonatomic, assign)CGFloat detailsHeight;
@end
