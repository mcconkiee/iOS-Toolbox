//
//  EMSwitch.m
//  CustomControls
//
//  Created by Eric McConkie on 8/1/13.
//  Copyright (c) 2013 customcontrols. All rights reserved.
//

#import "EMSwitch.h"

#define maxRight    0.0

@interface EMSwitch ()
@property (nonatomic,weak)UIView *track;
@property (nonatomic,weak)UIImageView *trackSliderImageView;
@property (nonatomic,weak)UIView *trackSliderImageViewContainer;

@property (nonatomic,weak)UIView *thumb;
@property (nonatomic,weak)UIImageView *thumbImageView;


@property (nonatomic)CGPoint lastTouch;
@property (nonatomic)CGFloat delta;
@property (nonatomic)NSTimeInterval onDownTimeInterval;
@property (nonatomic)NSTimeInterval onUpTimeInterval;
@property (nonatomic)CGFloat maxLeft;

@end

@implementation EMSwitch



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *trackImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [trackImageView setContentMode:UIViewContentModeCenter];
        [self setTrackSliderImageView:trackImageView];
        UIView *vv = [[UIView alloc] initWithFrame:CGRectZero];
        [vv setBackgroundColor:[UIColor clearColor]];
        [self setTrackSliderImageViewContainer:vv];
        [vv addSubview:self.trackSliderImageView];
        [self addSubview:vv];
        [self setTrack:vv];
        
        UIImageView *thumbImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self setThumbImageView:thumbImgView];
        [vv addSubview:thumbImgView];
        
        UIImage *i = [UIImage imageNamed:@"track"];
        [self setTrackImage:i];
        UIImage *origThumbImage = [UIImage imageNamed:@"thumb"];
        [self setThumbImage:origThumbImage];
        
        [self setClipsToBounds:YES];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setIsOn:YES];
        
    }
    return self;
}
-(void)setTrackImage:(UIImage *)asliderImage{
    _trackImage = asliderImage;
    self.maxLeft = (self.thumbImage.size.width/2) - (self.trackImage.size.width/2)  ;
    [self.trackSliderImageViewContainer setFrame:CGRectMake(0, 0, asliderImage.size.width, asliderImage.size.height)];
    self.trackSliderImageView.frame = self.trackSliderImageViewContainer.frame ;
    [self.trackSliderImageView setImage:asliderImage];
    self.delta= 0.0;    
    [self setNeedsDisplay];
}
-(void)setThumbImage:(UIImage *)athumbImage{
    _thumbImage = athumbImage;
    self.maxLeft = (self.thumbImage.size.width/2) - (self.trackImage.size.width/2)  ;
    self.thumbImageView.frame = CGRectMake(self.frame.size.width - self.thumbImage.size.width, 0, self.thumbImage.size.width, self.thumbImage.size.height);
    [self.thumbImageView setImage:self.thumbImage];
    
    [self setNeedsDisplay];
}

-(void)setIsOn:(BOOL)aisOn
{
    [self setIsOn:aisOn animated:YES];
}
-(void)setIsOn:(BOOL)aisOn animated:(BOOL)animated
{
    [self setIsOn:aisOn animated:animated speed:0.4];
}

-(void)setIsOn:(BOOL)aisOn animated:(BOOL)animated speed:(float)speed
{
    BOOL olVal = _isOn;
    _isOn = aisOn;
    CGRect thumbrect = self.track.frame;
    if (_isOn) {
        thumbrect.origin.x = maxRight;
    }else
        thumbrect.origin.x = self.maxLeft;
    
    if (animated) {
        [UIView animateWithDuration:speed animations:^{
            [self.track setFrame:thumbrect];
        }];
    }else
        [self.track setFrame:thumbrect];
    
    if (olVal!=_isOn) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}


-(void)onTap:(UITapGestureRecognizer*)tap
{
    CGPoint here = [tap locationInView:self];
    CGFloat half = self.frame.size.width/2;
    if (here.x > half) {//right tap
        [self setIsOn:YES];
    }else
        [self setIsOn:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.onDownTimeInterval = [[NSDate date] timeIntervalSince1970];
    self.lastTouch = [touch locationInView:self];
    self.delta = [touch locationInView:self].x - self.track.frame.origin.x ;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint curTouch = [touch locationInView:self];
    float x = (curTouch.x - self.delta);
    NSLog(@"x\r\n---> %f",self.track.frame.origin.x);
    if(x>maxRight)
        x = maxRight;
    if (x<self.maxLeft)
        x= self.maxLeft;

    [self.track setFrame:CGRectMake(x, 0, self.track.frame.size.width, self.track.frame.size.height)];

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.onUpTimeInterval = [[NSDate date] timeIntervalSince1970];
    double timePast = (self.onUpTimeInterval - self.onDownTimeInterval);
    BOOL isTap = timePast<0.15;
    
    UITouch *touch = [touches anyObject];
    CGPoint here = [touch locationInView:self];
    CGFloat half = self.frame.size.width/2;
    float x = (self.lastTouch.x - here.x);
    if (isTap) {//treat this as a tap
        
        if (here.x > half) {//right tap
            [self setIsOn:YES];
        }else
            [self setIsOn:NO];
        return;
    }else{//treat this as a slide
        BOOL isOffDirection = self.lastTouch.x > here.x;
        BOOL isSufficient = abs(x)>half/2;
       
        if (isSufficient) {
            [self setIsOn:!isOffDirection animated:NO];
        }else
            [self setIsOn:self.isOn animated:NO];
    }
    
    
    
}



@end
