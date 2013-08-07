//
//  UIImage+EM.h
//  ImageMasktest
//
//  Created by Eric McConkie on 3/5/13.
//  Copyright (c) 2013 Eric McConkie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EM)

//masks
+(UIImage *)maskImage:(UIImage*)image simpleImageMask:(UIImage*)maskImage  ;
-(void)maskImageView:(UIImageView*)iv withLayerImage:(UIImage*)mask;
-(UIImage*) maskImageWithMask:(UIImage *)aMaskImage ;//colorized

//resize t
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
-(UIImage*)scaleToWidth:(float)scaleWidth;

//orientation
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
@end
