//
//  FaceDetectionManagerDelegate.h
//  VerificationSelfieFramework
//
//  Created by Raghad's Mac on 26/07/2024.
//


#import <UIKit/UIKit.h>
#import <Vision/Vision.h>

// Use NS_ASSUME_NONNULL_BEGIN and NS_ASSUME_NONNULL_END to improve nullability annotations
NS_ASSUME_NONNULL_BEGIN

// Define the FaceDetectionManagerDelegate protocol
@protocol FaceDetectionManagerDelegate <NSObject>

- (void)didDetectFaces:(NSArray<VNFaceObservation *> *)faceObservations;
- (void)didEncounterError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
