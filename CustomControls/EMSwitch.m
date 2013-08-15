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

        
        [self addObserver:self forKeyPath:@"isOn" options:NSKeyValueObservingOptionNew context:kFOTFKVOContext];
        
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isOn"]) {
        NSLog(@"change\r\n---> %@",change);
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}
- (void)dealloc
{
    
    [self removeObserver:self forKeyPath:@"isOn" context:kFOTFKVOContext];
}
-(void)setTrackImage:(UIImage *)asliderImage{
    _trackImage = asliderImage;
    self.maxLeft = (self.thumbImage.size.width/2) - (self.trackImage.size.width/2)  ;
    [self.trackSliderImageViewContainer setFrame:CGRectMake(0, 0, asliderImage.size.width, asliderImage.size.height)];
    self.trackSliderImageView.frame = self.trackSliderImageViewContainer.frame ;
    [self.trackSliderImageView setImage:asliderImage];
    self.delta= 0.0;
    
    [self setFrame:CGRectMake(self.frame.origin.x,
                              self.frame.origin.y,
                              self.trackImage.size.width/2 + self.thumbImage.size.width/2,self.thumbImage.size.height)];
    
    [self setNeedsDisplay];
}
-(void)setThumbImage:(UIImage *)athumbImage{
    _thumbImage = athumbImage;
    self.maxLeft = (self.thumbImage.size.width/2) - (self.trackImage.size.width/2)  ;
    self.thumbImageView.frame = CGRectMake(self.trackImage.size.width/2 - self.thumbImage.size.width/2, 0, self.thumbImage.size.width, self.thumbImage.size.height);
    [self.thumbImageView setImage:self.thumbImage];
    [self setFrame:CGRectMake(self.frame.origin.x,
                              self.frame.origin.y,
                              self.trackImage.size.width/2 + self.thumbImage.size.width/2,self.thumbImage.size.height)];
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
    
    
}


-(void)onTap:(UITapGestureRecognizer*)tap
{
    BOOL canSwitch = YES;
    if ([self.delegate respondsToSelector:@selector(emSwitchCanSwitch:)]) {
        canSwitch = [self.delegate emSwitchCanSwitch:self];
    }
    if (!canSwitch) {
        return;
    }
    
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
    
    BOOL canSwitch = YES;
    if ([self.delegate respondsToSelector:@selector(emSwitchCanSwitch:)]) {
        canSwitch = [self.delegate emSwitchCanSwitch:self];
    }
    if (!canSwitch) {
        return;
    }
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
