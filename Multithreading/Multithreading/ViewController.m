#import "ViewController.h"

static NSInteger const lastNumber = 20000;

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextView *numbersTextView;

@end

@implementation ViewController

- (IBAction)startButton
{
    self.numbersTextView.text = @"2";

    typeof(self) __weak wself = self;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSUInteger n = 3; n < lastNumber; n++) {
            if ([wself checkNumberForPrime:n]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    wself.numbersTextView.text = [wself.numbersTextView.text stringByAppendingFormat:@", %lu", n];
                });
            }
            sleep(1);
        }

    });
}

- (BOOL)checkNumberForPrime:(NSUInteger)n
{
    for (int i = 2; i < n; i++) {
        if (n % i == 0) {
            return NO;
        }
    }
    return YES;
}


@end