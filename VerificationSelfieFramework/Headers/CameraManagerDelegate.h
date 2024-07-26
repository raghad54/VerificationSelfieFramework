//
//  CameraManagerDelegate.h
//  VerificationSelfieFramework
//
//  Created by Raghad's Mac on 26/07/2024.
//

#import <UIKit/UIKit.h>
#import <Vision/Vision.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CameraManagerDelegate <NSObject>

- (void)didCaptureImage:(UIImage *)image;
- (void)didDetectFaces:(NSArray<VNFaceObservation *> *)faceObservations;
- (void)didEncounterError:(ErrorsHandlerForOpenCamaerEnum)error;

@end

NS_ASSUME_NONNULL_END
