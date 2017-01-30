//
//  ContactVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/29/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "ContactVC.h"
#import "IonIcons.h"
#import "ATRuntime.h"
#import <SafariServices/SafariServices.h>

@interface ContactVC (){
    IBOutlet UIButton *callButton;
    IBOutlet UIButton *emailButton;
    IBOutlet UIImageView *arrowView;
    IBOutlet UIImageView *arrowView2;
    IBOutlet UILabel *contactLabel;
    IBOutlet UIView *contactView;
    UITextField *messageField;
    UITextField *nameField;
    UITextField *emailField;
    MFMailComposeViewController *mail;
    IBOutlet UIView *sourceView;
}

@end

@implementation ContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [callButton setImage:[IonIcons imageWithIcon:ioniostelephone size:40 color:[ATRuntime nmcGreen]] forState:UIControlStateNormal];
    [emailButton setImage:[IonIcons imageWithIcon:ioniosemail size:40 color:[ATRuntime nmcGreen]] forState:UIControlStateNormal];
    arrowView.image = [IonIcons imageWithIcon:ioniosarrowforward size:40 color:[UIColor grayColor]];
    arrowView2.image = [IonIcons imageWithIcon:ioniosarrowforward size:40 color:[UIColor grayColor]];
    contactLabel.text = [[[ATRuntime data] config] objectForKey:@"contactText"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contactDeveloper)];
    [contactView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sourceView)];
    [sourceView addGestureRecognizer:tap2];
}

-(void)sourceView{
    SFSafariViewController *sourceVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://github.com/apollo-technology/NMCMusic/tree/master/NMCMusic/NMCMusic"]];
    sourceVC.view.tintColor = [ATRuntime nmcGreen];
    [self.navigationController pushViewController:sourceVC animated:YES];
}

-(void)contactDeveloper{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Contact Developer" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Name";
        textField.text = @"";
        textField.returnKeyType = UIReturnKeyContinue;
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.secureTextEntry = NO;
        textField.autocorrectionType = UITextAutocorrectionTypeDefault;
        nameField = textField;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Email";
        textField.text = @"";
        textField.returnKeyType = UIReturnKeyContinue;
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.secureTextEntry = NO;
        textField.autocorrectionType = UITextAutocorrectionTypeDefault;
        emailField = textField;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Message";
        textField.text = @"";
        textField.returnKeyType = UIReturnKeyContinue;
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        textField.secureTextEntry = NO;
        textField.autocorrectionType = UITextAutocorrectionTypeDefault;
        messageField = textField;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Send" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Loading" message:@"\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.center = CGPointMake(130.5, 80);
        spinner.color = [UIColor grayColor];
        [spinner startAnimating];
        [alert.view addSubview:spinner];
        [self presentViewController:alert animated:YES completion:^{
            PFObject *object = [PFObject objectWithClassName:@"message"];
            object[@"name"] = nameField.text;
            object[@"email"] = emailField.text;
            object[@"message"] = messageField.text;
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                [self dismissViewControllerAnimated:YES completion:^{
                    if (succeeded) {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sent" message:@"We will get back to you shortly." preferredStyle:UIAlertControllerStyleAlert];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                        [self presentViewController:alertController animated:YES completion:nil];
                    } else {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                        [self presentViewController:alertController animated:YES completion:^{
                            
                        }];
                    }
                }];
            }];
        }];
    }]];
    alertController.view.tintColor = [ATRuntime nmcGreen];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(IBAction)callAction:(id)sender{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://2319951338"]]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you want to call?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://2319951338"]];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        alertController.view.tintColor = [UIColor colorWithRed:0.086 green:0.518 blue:0.400 alpha:1.00];
        [self presentViewController:alertController animated:YES completion:^{
            alertController.view.tintColor = [UIColor colorWithRed:0.086 green:0.518 blue:0.400 alpha:1.00];
        }];
    }
}

-(IBAction)emailAction:(id)sender{
    if ([MFMailComposeViewController canSendMail])
    {
        mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@""];
        [mail setMessageBody:@"" isHTML:NO];
        [mail setToRecipients:@[@"jecobb@nmc.edu"]];
        
        [self presentViewController:mail animated:YES completion:nil];
    }
    else
    {
        NSLog(@"This device cannot send email");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Hmm." message:@"Your device cannot send mail." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *title;
    BOOL Show;
    Show = YES;
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            title = @"Email Sent!";
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            title = @"Draft Sent!";
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            Show = NO;
            title = @"You cancelled sending the email.";
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            title = @"Error, try again.";
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            title = @"Error, try again.";
            break;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [self viewDidLoad];
        if (Show) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

@end
