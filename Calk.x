//Calk ~ Obumbravit

//imports
@import UIKit;

@interface Button
- (void)openWave;
@end

%hook Button

static CGFloat i;

- (void)didMoveToWindow
{
    %orig();
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:@"/var/mobile/Documents/CalkTemp"])
    {
        [self openWave];
        NSError * error = nil;
        [fileManager removeItemAtPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"CalkTemp"] error:&error];
    }
}

- (void)setBackgroundColor:(UIColor *)arg1
{
    if (i != 2.5) %orig(arg1);
    else %orig([UIColor blackColor]);
}

%new
- (void)openWave
{
    if (!i) i = 0.125;
    i = i + 0.125;

    [NSTimer scheduledTimerWithTimeInterval:i target:[NSBlockOperation blockOperationWithBlock:^{
        [UIView animateWithDuration:0.125 animations:^{
            [self setBackgroundColor:[UIColor whiteColor]];
        } completion:NULL];
        [NSTimer scheduledTimerWithTimeInterval:0.125 target:[NSBlockOperation blockOperationWithBlock:^{
            [UIView animateWithDuration:0.125 animations:^{
                [self setBackgroundColor:[UIColor blackColor]];
            } completion:NULL];
            if (i == 2.375) i = 2.5;
        }] selector:@selector(main) userInfo:nil repeats:NO];
    }] selector:@selector(main) userInfo:nil repeats:NO];
}

%end

%hook UILabel

- (void)setTextColor:(UIColor *)arg1
{
    %orig([UIColor whiteColor]);
}

%end

%ctor
{
    %init(Button = objc_getClass("Calculator.CalculatorKeypadButton"));
}