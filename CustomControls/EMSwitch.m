//
//  EMSwitch.m
//  CustomControls
//
//  Created by Eric McConkie on 8/1/13.
//  Copyright (c) 2013 customcontrols. All rights reserved.
//

#import "EMSwitch.h"
#define maxleft -57.0
#define maxRight 0.0
@interface EMSwitch ()
@property (nonatomic,weak)UIView *thumb;
@property (nonatomic)CGPoint lastTouch;
@property (nonatomic)CGFloat delta;
@property (nonatomic)NSTimeInterval onDownTimeInterval;
@property (nonatomic)NSTimeInterval onUpTimeInterval;
@end

@implementation EMSwitch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.thumb =[self createThumb];
        [self addSubview:self.thumb];
        [self setClipsToBounds:YES];
        [self setBackgroundColor:[UIColor clearColor]];
       
        
    }
    return self;
}

-(UIView*)createThumb
{
    UIImage *i = [UIImage imageNamed:@"thumb"];
    UIImageView *v = [[UIImageView alloc] initWithImage:i];
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, i.size.width, i.size.height)];
    [vv addSubview:v];
    
    self.delta= 0.0;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
//    [vv addGestureRecognizer:tap];
    
    return vv;
}

-(void)setIsOn:(BOOL)aisOn
{
    _isOn = aisOn;
    CGRect thumbrect = self.thumb.frame;
    if (_isOn) {
        thumbrect.origin.x = maxRight;
    }else
        thumbrect.origin.x = maxleft;
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.thumb setFrame:thumbrect];
    }];
}


-(void)onTap:(UITapGestureRecognizer*)tap
{

        NSLog(@"tap\r\n---> %@",tap);
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
    self.delta = [touch locationInView:self].x - self.thumb.frame.origin.x ;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint curTouch = [touch locationInView:self];
    float x = (curTouch.x - self.delta);
    if(x>maxRight)
        x = maxRight;
    if (x<maxleft)
        x= maxleft;

    [self.thumb setFrame:CGRectMake(x, 0, self.thumb.frame.size.width, self.thumb.frame.size.height)];

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.onUpTimeInterval = [[NSDate date] timeIntervalSince1970];
    double timePast = (self.onUpTimeInterval - self.onDownTimeInterval);
    NSLog(@"timepast\r\n---> %f",timePast);
    BOOL isTap = timePast<0.15;
    
    UITouch *touch = [touches anyObject];
    CGPoint here = [touch locationInView:self];
    CGFloat half = self.frame.size.width/2;
    float x = (self.lastTouch.x - here.x);
    if (isTap) {
        
        if (here.x > half) {//right tap
            [self setIsOn:YES];
        }else
            [self setIsOn:NO];
        return;
    }else{
        BOOL isOffDirection = self.lastTouch.x > here.x;
        BOOL isSufficient = abs(x)>half/2;
       
        if (isSufficient) {
            [self setIsOn:!isOffDirection];
        }else
            [self setIsOn:self.isOn];
    }
    
    
    
}
#pragma mark -
#pragma mark GESTURE



@end
