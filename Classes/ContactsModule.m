//
//  ContactsModule.m
//  Prey-iOS
//
//  Created by Carlos Yaconi on 20/10/2010.
//  Copyright 2010 Fork Ltd. All rights reserved.
//  License: GPLv3
//  Full license at "/LICENSE"
//

#import "ContactsModule.h"
#import <AddressBook/AddressBook.h>


@implementation ContactsModule
@synthesize data;
- (void)main {
	// AddressBook
    self.data = [[NSMutableArray alloc] init];
	ABAddressBookRef ab;
	ab = ABAddressBookCreate();
    NSArray *people = (NSArray *)ABAddressBookCopyArrayOfAllPeople(ab);
    int len = (int) ABAddressBookGetPersonCount(ab);
	for(int i = 0; i < len; i++)
	{
        
		ABRecordRef person = [people objectAtIndex:i];
		NSString *field;
        NSMutableDictionary *dicty = [[[NSMutableDictionary alloc] init] autorelease];
        field = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
		if (field != nil) {
            [dicty setValue:field forKey:@"firstName"];
        }
        
        field = (NSString *)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
		if (field != nil) {
            [dicty setValue:field forKey:@"middleName"];
        }
        
        field = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        if (field != nil) {
            [dicty setValue:field forKey:@"lastName"];
        }
        
        field = (NSString *)ABRecordCopyValue(person, kABPersonPrefixProperty);
		if (field != nil) {
            [dicty setValue:field forKey:@"prefix"];
        }
        
        field = (NSString *)ABRecordCopyValue(person, kABPersonSuffixProperty);
		if (field != nil) {
            [dicty setValue:field forKey:@"suffix"];
        }
        
        field = (NSString *)ABRecordCopyValue(person, kABPersonNicknameProperty);
		if (field != nil) {
            [dicty setValue:field forKey:@"nickname"];
        }
        
        field = (NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
		if (field != nil) {
            [dicty setValue:field forKey:@"organization"];
        }
        
        field = (NSString *)ABRecordCopyValue(person, kABPersonJobTitleProperty);
		if (field != nil) {
            [dicty setValue:field forKey:@"jobTitle"];
        }
        field = (NSString *)ABRecordCopyValue(person, kABPersonDepartmentProperty);
		if (field != nil) {
            [dicty setValue:field forKey:@"department"];
        }
        
        ABMultiValueRef TS = ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSArray *multifield = (NSArray *)ABMultiValueCopyArrayOfAllValues(TS);
        CFRelease(TS);
        [dicty setValue:multifield forKey:@"telNumbers"];
        [multifield release];
        
        TS = ABRecordCopyValue(person, kABPersonEmailProperty);
        multifield = (NSArray *)ABMultiValueCopyArrayOfAllValues(TS);
        CFRelease(TS);
        [dicty setValue:multifield forKey:@"emails"];
        [multifield release];

        NSLog(@"%@", dicty);
		
		[self.data addObject:dicty];
		[dicty release];
	}
	
}

- (NSString *) getName {
	return @"contacts";
}


@end
