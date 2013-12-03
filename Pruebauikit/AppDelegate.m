//
//  AppDelegate.m
//  Pruebauikit
//
//  Created by Sofía Swidarowicz on 26/03/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"
#import "AppDelegate.h"
#import "GameConfig.h"
#import "HelloWorldLayer.h"
#import "RootViewController.h"
#import "GameScene.h"

@implementation AppDelegate

@synthesize window, notifyCenter, general;

- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

//	CC_ENABLE_DEFAULT_GL_STATES();
//	CCDirector *director = [CCDirector sharedDirector];
//	CGSize size = [director winSize];
//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
//	sprite.position = ccp(size.width/2, size.height/2);
//	sprite.rotation = -90;
//	[sprite visit];
//	[[director openGLView] swapBuffers];
//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}
- (void)applicationDidFinishLaunching:(UIApplication *)application
{    
	self.notifyCenter = [NSNotificationCenter defaultCenter];
	[notifyCenter addObserver:self selector:@selector(trackNotifications:) name:nil object:nil];
	
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    [window setUserInteractionEnabled:YES];
    [window setMultipleTouchEnabled:YES];
	
	CCDirector *director = [CCDirector sharedDirector];
	
    // Create an EAGLView with a RGB8 color buffer, and a depth buffer of 24-bits
	EAGLView *glView = [EAGLView viewWithFrame:[window frame]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	[glView setMultipleTouchEnabled:YES]; 
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	// make the OpenGLView a child of the main window
	[window addSubview:glView];
	
	// make main window visible
	[window makeKeyAndVisible];	
    GameScene *gs = [GameScene node];
	
    [[CCDirector sharedDirector] runWithScene:gs];
    

   	General *principal;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        principal = [[General alloc] initWithNibName:@"General-iPad" bundle:nil];
    } else {
        principal = [[General alloc] initWithNibName:@"General" bundle:nil];
    }
	self.general = principal;
	[principal release];
	[self showUIViewController:general];
}


- (void) trackNotifications: (NSNotification *) notification
{
	id nname = [notification name];
	
	if([nname isEqual:@"empezarPrueba"])
	{
		[self hideUIViewController:general];
		
		// Obtain the shared director in order to...
		CCDirector *director = [CCDirector sharedDirector];
		
		// Sets landscape mode
		[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
		//CCDeviceOrientationPortrait
		// Turn on display FPS
		[director setDisplayFPS:NO];
		
		// Turn on multiple touches
		EAGLView *view = [director openGLView];
		[view setMultipleTouchEnabled:YES];
		
		// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
		// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
		// You can change anytime.
		[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];	
		[[CCDirector sharedDirector] pushScene: [CCTransitionMoveInB transitionWithDuration:0.0f scene:[HelloWorldLayer scene]]];
	
	}
	

}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void) showUIViewController:(UIViewController *) controller
{
	[[CCDirector sharedDirector] pause];
	
	/*[UIView beginAnimations:nil context:NULL];
	 [UIView setAnimationDuration:.5];
	 [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[[CCDirector sharedDirector] openGLView] cache:YES];
	 */
	[[[CCDirector sharedDirector] openGLView] addSubview:controller.view];
	[UIView commitAnimations];
	
}

- (void) hideUIViewController:(UIViewController *) controller
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animDone:finished:context:)];
	
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[[CCDirector sharedDirector] openGLView] cache:YES];
	
	[controller.view removeFromSuperview];
	
	[UIView commitAnimations];
}


- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
	[super dealloc];
}

@end
