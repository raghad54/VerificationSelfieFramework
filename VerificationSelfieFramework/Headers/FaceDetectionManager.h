//
//  FaceDetectionManager.h
//  VerificationSelfie
//
//  Created by Raghad's Mac on 25/07/2024.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Vision/Vision.h>

NS_ASSUME_NONNULL_BEGIN

@interface FaceDetectionManager : NSObject

// Add public properties and methods here
- (void)performFaceDetectionOnImage:(CIImage *)image
                          completion:(void (^)(NSArray<VNFaceObservation *> *faceObservations))completion;

@end

NS_ASSUME_NONNULL_END
