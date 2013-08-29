#import "Kiwi.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "LightEngine.h"

@interface ViewController (UITests)
@property (nonatomic, weak) id delegate;
@property (weak, nonatomic) IBOutlet UIView *upRed;
@property (weak, nonatomic) IBOutlet UIView *upAmber;
@property (weak, nonatomic) IBOutlet UIView *upGreen;
@property (weak, nonatomic) IBOutlet UIView *downRed;
@property (weak, nonatomic) IBOutlet UIView *downAmber;
@property (weak, nonatomic) IBOutlet UIView *downGreen;
@property (weak, nonatomic) IBOutlet UIImageView *stopImageview;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *tickButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (nonatomic, strong) NSArray *upLights;
@property (nonatomic, strong) NSArray *downLights;
- (IBAction)didTapStartButton:(id)sender;
- (IBAction)didTapTickButton:(id)sender;
- (IBAction)didTapStopButton:(id)sender;
@end

SPEC_BEGIN(UITests)

describe(@"The view controller", ^{
    
    __block ViewController *vc = nil;
    
    beforeEach(^{
        vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    });
    
    it(@"should have a delegate property", ^{
        [[vc should] respondToSelector:@selector(delegate)];
    });
    
    it(@"should have a delegate set when it is instantiated", ^{
        AppDelegate *appDelegate = [[AppDelegate alloc] init];
        [appDelegate application:nil didFinishLaunchingWithOptions:nil];
        [[(NSObject *)appDelegate.viewController.delegate should] conformToProtocol:@protocol(LightEngineProtocol)];
    });
    
});

describe(@"The user interface", ^{

    __block ViewController *vc = nil;
    
    beforeAll(^{
    });
    
    beforeEach(^{
        vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [vc view];
    });
    
    context(@"when in the default state", ^{
        
        it(@"should show all lights as black", ^{
            [[vc.upRed.backgroundColor should] equal:[UIColor blackColor]];
            [[vc.upAmber.backgroundColor should] equal:[UIColor blackColor]];
            [[vc.upGreen.backgroundColor should] equal:[UIColor blackColor]];
            
            [[vc.downRed.backgroundColor should] equal:[UIColor blackColor]];
            [[vc.downAmber.backgroundColor should] equal:[UIColor blackColor]];
            [[vc.downGreen.backgroundColor should] equal:[UIColor blackColor]];
        });
        
        afterEach(^{
        });
        
        afterAll(^{
        });
        
    });
    
    context(@"when responding to user input", ^{
        
       it(@"should turn both red lights on in response to the start button", ^{
           [vc didTapStartButton:nil];
           [[vc.upRed.backgroundColor should] equal:[UIColor redColor]];
           [[vc.upAmber.backgroundColor should] equal:[UIColor blackColor]];
           [[vc.upGreen.backgroundColor should] equal:[UIColor blackColor]];
           
           [[vc.downRed.backgroundColor should] equal:[UIColor redColor]];
           [[vc.downAmber.backgroundColor should] equal:[UIColor blackColor]];
           [[vc.downGreen.backgroundColor should] equal:[UIColor blackColor]];
       });
        
        it(@"should send a 'tick' message to the delegate when the Tick button is tapped", ^{
            id delegateMock = [KWMock mockForProtocol:@protocol(LightEngineProtocol)];
            [[delegateMock should] conformToProtocol:@protocol(LightEngineProtocol)];
            [vc setDelegate:delegateMock];
            [[delegateMock should] receive:@selector(tick) andReturn:@164];
            [vc didTapTickButton:nil];
        });

        
    });
    
   
});

SPEC_END