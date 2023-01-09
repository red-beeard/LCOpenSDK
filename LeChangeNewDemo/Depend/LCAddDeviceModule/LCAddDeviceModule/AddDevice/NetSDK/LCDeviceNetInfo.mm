

#import "LCDeviceNetInfo.h"
#import <LCOpenSDKDynamic/LCOpenSDKDynamic.h>

@implementation LCDeviceNetInfo
- (instancetype)initWithNetInfo:(LCOpenSDK_SearchDeviceInfo *)pDevice {
    if(self = [super init]) {
        self.ipVersion          = pDevice.ipVersion;
        self.ip                 = pDevice.ip;
        self.port               = pDevice.port;
        self.submask            = pDevice.submask;
        self.mac                = pDevice.mac;
        self.gateway            = pDevice.gateway;
        self.deviceType         = pDevice.deviceType;
        self.definition         = pDevice.definition;
        self.manuFactory        = pDevice.manuFactory;
        self.dhcpEn             = pDevice.dhcpEn;
        self.reserved1          = pDevice.reserved1;
        self.verifyData         = pDevice.verifyData;
        self.serialNo           = pDevice.serialNo;
        self.devSoftVersion     = pDevice.devSoftVersion;
        self.detailType         = pDevice.detailType;
        self.vendor             = pDevice.vendor;
        self.devName            = pDevice.devName;
        self.userName           = pDevice.userName;
        self.passWord           = pDevice.passWord;
        self.httpPort           = pDevice.httpPort;
        self.videoInputCh       = pDevice.videoInputCh;
        self.remoteVideoInputCh = pDevice.remoteVideoInputCh;
        self.videoOutputCh      = pDevice.videoOutputCh;
        self.alarmInputCh       = pDevice.alarmInputCh;
        self.alarmOutputCh      = pDevice.alarmOutputCh;
        self.newWordLen         = pDevice.newWordLen;
        self.nowPassWord        = pDevice.nowPassWord;
        self.initStatus         = pDevice.initStatus;
        self.byPWDResetWay      = pDevice.byPWDResetWay;
        self.specialAbility     = pDevice.specialAbility;
        self.nowDetailType      = pDevice.nowDetailType;
        self.bNowUserName       = pDevice.bNowUserName;
        self.nowUserName        = pDevice.nowUserName;
        self.searchSequence = pDevice.searchSequence;
	}
	
    return self;
}

#pragma mark - ISearchDeviceNetInfo

- (NSString *)deviceSN
{
    return self.serialNo;
}

- (NSString *)deviceIP
{
    return self.ip;
}

- (NSString *)deviceMac
{
    return self.mac;
}

- (LCDevicePasswordResetType)devicePwdResetWay
{
    LCDevicePasswordResetType type = LCDevicePasswordResetUnkown;
	if ((self.byPWDResetWay >> 3) & 0B01) {
		type = LCDevicePasswordResetPresetPhone;
	} else if ((self.byPWDResetWay >> 1) & 0B01) {
		type = LCDevicePasswordResetPresetEmail;
	} else if (self.byPWDResetWay & 0B01) {
		type = LCDevicePasswordResetPresetPhone;
	}
	
	return type;
}

- (LCIPType)ipType
{
    return (LCIPType)self.ipVersion;
}

- (LCDeviceInitType)deviceInitType
{
    int bySpecialAbility = self.specialAbility;
    int flag = (bySpecialAbility >> 2)&0B11;
    if (flag == 0B00) {
        //老设备
        return LCDeviceInitTypeOldDevice;
    }else if (flag == 0B01){
        //IP无效
        return LCDeviceInitTypeIPUnable;
    }else if (flag == 0B10){
        //IP有效
        return LCDeviceInitTypeIPEnable ;
    }
	
    return LCDeviceInitTypeOldDevice;
}

- (LCDeviceInitStatus)deviceInitStatus
{
    unsigned char byInitStatus = self.initStatus;
    if((byInitStatus & 0B01) == 0B01)
    {
        return LCDeviceInitStatusUnInit;
    }
    else if((byInitStatus & 0B10) == 0B10)
    {
        return LCDeviceInitStatusInit;
    }

    
    return LCDeviceInitStatusNoAbility;
}

- (void)setDeviceInitStatus:(LCDeviceInitStatus)status {
	if (status == LCDeviceInitStatusInit) {
		self.initStatus = (self.initStatus & (0xFF << 2)) | 0B10;
	} else if (status == LCDeviceInitStatusUnInit) {
		self.initStatus = (self.initStatus & (0xFF << 2)) | 0B01;
	}
}


- (BOOL)isSupportPWDReset {
	// bit6~7: 0- 未知 1-不支持密码重置 2-支持密码重置
    unsigned char status = (self.initStatus >> 6) & 0B11 ;
	if (status == 2) {
		//只有这一种情况才支持重置
		return YES;
	}
	
	return NO;
}

//@property (nonatomic, copy)NSString *deviceSN; // 序列号
//@property (nonatomic, copy)NSString *deviceIP; // 设备IP
@end




//MARK: Product Definition
@implementation LCDeviceProductDefinition

@synthesize deviceInitStatus;

@synthesize deviceInitType;

@synthesize deviceIP;

@synthesize deviceMac;

@synthesize devicePwdResetWay;

@synthesize deviceSN;

@synthesize ipType;

@synthesize isSupportPWDReset;

@synthesize isVaild;

@synthesize port;

@synthesize searchSequence;

@end

//MARK: LCDeviceUserInfoDefinition
@implementation LCDeviceUserInfoDefinition

@end

//MARK: LCNetLoginDeviceInfo
@implementation LCNetLoginDeviceInfo

@end
