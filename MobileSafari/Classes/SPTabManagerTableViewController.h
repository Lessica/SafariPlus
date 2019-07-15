// SPTabManagerTableViewController.h
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

@class TabController, TabDocument;

@interface SPTabManagerTableViewController : UITableViewController <UISearchResultsUpdating>
{
	TabController* _tabController;
	NSArray<TabDocument*>* _allTabs;
	NSArray<TabDocument*>* _filteredTabs;
	NSArray<TabDocument*>* _selectedTabs;
	NSArray<TabDocument*>* _displayedTabs;
	TabDocument* _initialVisibleTab;
	BOOL _isFiltering;
	BOOL _shouldUpdateOnSelectionChange;
	UISearchController* _searchController;
	UIBarButtonItem* _addTabsBarButtonItem;
	UIBarButtonItem* _exportBarButtonItem;
	UIBarButtonItem* _addToBookmarksBarButtonItem;
	UIBarButtonItem* _closeTabsBarButtonItem;
	UIBarButtonItem* _lockUnlockBarButtonItem;
}
@property (nonatomic) BOOL lockBarButtonIsUnlockButton;
- (instancetype)initWithTabController:(TabController*)tabController;
- (void)setUpTopBar;
- (void)setUpBottomToolbar;
- (NSArray<TabDocument*>*)activeTabs;
- (UIViewController*)presentationController;
- (TabDocument*)tabDocumentForIndexPath:(NSIndexPath*)indexPath;
- (NSIndexPath*)indexPathForTabDocument:(TabDocument*)tabDocument;
- (BOOL)loadTabs;
- (void)reloadAnimated:(BOOL)animated;
- (void)updateSelectAllButton;
- (void)selectAll;
- (void)deselectAll;
- (void)doneButtonPressed;
- (void)selectAllButtonPressed;
- (void)addTabsButtonPressed;
- (void)openAllURLsInsideString:(NSString*)string;
- (void)addToBookmarksButtonPressed;
- (void)closeTabsButtonPressed;
- (void)exportButtonPressed:(id)sender;
- (void)updateSelectedTabs;
@end
