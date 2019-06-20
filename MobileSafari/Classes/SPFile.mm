// SPFile.mm
// (c) 2017 - 2019 opa334

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

#import "SPFile.h"
#import "Extensions.h"

#import "../Util.h"
#import "SPFileManager.h"
#import "SPCommunicationManager.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <QuickLook/QuickLook.h>

@implementation SPFile

- (instancetype)initWithFileURL:(NSURL*)fileURL
{
	self = [super init];

	_fileURL = fileURL;

	_name = [_fileURL lastPathComponent];

  #ifndef PREFERENCES
	if([_name isUUID])
	{
		_applicationDisplayName = [fileManager applicationDisplayNameForURL:_fileURL];
	}
  #endif

	if(_applicationDisplayName)
	{
		NSMutableAttributedString* cellTitleM = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@)", _applicationDisplayName, _name]];

		NSDictionary* appNameAttributes =
			@{
				NSForegroundColorAttributeName : [UIColor colorWithRed:50.0f/255.0f green:100.0f/255.0f blue:150.0f/255.0f alpha:1.0f]
		};

		NSRange range = NSMakeRange(0, [_applicationDisplayName length]);

		[cellTitleM setAttributes:appNameAttributes range:range];

		_cellTitle = [cellTitleM copy];
	}
	else
	{
		_cellTitle = [[NSAttributedString alloc] initWithString:_name];
	}

	NSNumber* isRegularFile;
	[fileManager URLResourceValue:&isRegularFile forKey:NSURLIsRegularFileKey forURL:_fileURL error:nil];
	_isRegularFile = [isRegularFile boolValue];

	NSNumber* size;
	[fileManager URLResourceValue:&size forKey:NSURLFileSizeKey forURL:_fileURL error:nil];
	_size = [size longLongValue];

	NSNumber* isWritable;
	[fileManager URLResourceValue:&isWritable forKey:NSURLIsWritableKey forURL:_fileURL error:nil];
	_isWritable = [isWritable boolValue];

	_isHidden = [[fileURL lastPathComponent] hasPrefix:@"."];

	CFStringRef fileExtension = (__bridge CFStringRef)[_fileURL pathExtension];
	_fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);

	_isPreviewable = [QLPreviewController canPreviewItem:_fileURL];

	return self;
}

- (BOOL)conformsTo:(CFStringRef)UTI
{
	return UTTypeConformsTo(_fileUTI, UTI);
}

- (BOOL)isEqual:(id)object
{
	if([object isKindOfClass:[SPFile class]])
	{
		SPFile* file = (SPFile*)object;

		if([self hash] == [file hash])
		{
			return YES;
		}
	}

	return NO;
}

- (NSUInteger)hash
{
	return [[self description] hash];
}

- (NSString*)description
{
	return [NSString stringWithFormat:@"<SPFile: filename = %@, fileURL = %@, size = %llu>", self.name, self.fileURL, self.size];
}

@end
