//
//  SHSQLiteManager.h
//  G4Image
//
//  Created by LHY on 2017/4/11.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "SHIBeacon.h"

@interface SHSQLiteManager : NSObject

/// 搜索所有的iBeacon
- (NSMutableArray *)searchiBeacons;

/// 获得最大的iBeaconID
- (NSUInteger)getMaxiBeaconID;

/// 删除一个iBeacon
- (BOOL)deleteiBeacon:(SHIBeacon *)iBeacon;

/// 插入一个新的iBeacon
- (BOOL)insertiBeacon:(SHIBeacon *)iBeacon;

SingletonInterface(SHSQLiteManager)

@end