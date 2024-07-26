//
//  PreviewViewControllerDelegate.h
//  VerificationSelfieFramework
//
//  Created by Raghad's Mac on 26/07/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PreviewViewControllerDelegate <NSObject>

- (void)didAcceptImage:(UIImage *)image;
- (void)didReject;

@end

NS_ASSUME_NONNULL_END
