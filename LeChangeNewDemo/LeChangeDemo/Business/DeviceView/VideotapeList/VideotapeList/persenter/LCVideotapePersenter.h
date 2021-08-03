//
//  Copyright © 2020 dahua. All rights reserved.
//


#import "LCUIKit.h"
#import "LCVideotapeListViewController.h"
#import "LCDeviceVideoManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCVideotapePersenter : LCBasicPresenter<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout>

/// 当前是否在编辑状态
@property (nonatomic) BOOL isEdit;

/// 当前是否在全选状态
@property (nonatomic) BOOL isSelectAll;

/// 当前是否在云录像模式
@property (nonatomic) BOOL isCloudMode;

///云录像列表
@property (nonatomic,strong)NSMutableArray <LCCloudVideotapeInfo *> * cloudVideoArray;

///本地录像列表
@property (nonatomic,strong)NSMutableArray<LCLocalVideotapeInfo *> * localVideoArray;

///视频播放管理者
@property (nonatomic,strong)LCDeviceVideoManager * videoManager;

///videoList
@property (nonatomic,retain)LCVideotapeListViewController * videoListPage;

///当前选择的时间
@property (nonatomic, strong) NSDate *currentDate;


/**
 刷新云录像
 */
-(void)refreshCloudVideoListWithDate:(nullable NSDate *)date;

/**
 刷新本地录像
 */
-(void)refreshLocalVideoListWithDate:(nullable NSDate *)date;

/**
 加载更多云录像
 */
-(void)loadMoreCloudVideoListWithDate:(nonnull NSDate *)date;

/**
 加载更多本地录像
 */
-(void)loadMoreLocalVideoListWithDate:(nonnull NSDate *)date;

/**
 删除云录像
 */
-(void)deleteCloudViewotape;
@end

NS_ASSUME_NONNULL_END
