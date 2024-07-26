//
//  PrepareCameraControllerDelegate.h
//  VerificationSelfieFramework
//
//  Created by Raghad's Mac on 26/07/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PrepareCameraControllerDelegate <NSObject>

- (void)didAcceptImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
