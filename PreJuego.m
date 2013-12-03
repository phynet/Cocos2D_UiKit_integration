//
//  PreJuego.m
//  iDStress
//
//  Created by Pold on 24/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PreJuego.h"


@implementation PreJuego


- (IBAction) empezarprueba:(id)sender{
	NSLog(@"hola Cocos2D prueba");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"empezarPrueba" object:@""];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Ir a Cocos2D";
	}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
   [super dealloc];
}


@end
