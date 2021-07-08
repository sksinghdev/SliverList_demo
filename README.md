# SliverList_demo


The project’s architecture is based on bloc pattern. StreamController has been used to populate the data in listView. Custom scroll view has been used for the list view. Sliver Appbar has been used for making searchbar. For Sliverlist header SliverToBoxAdapter has been used. For showing the list, Sliverlist is used and also SliverChildBuilderDelegate delegate used for particular row index. For showing name detail page Inkwell is used and for navigation navigator push is used. For sending data from list page to detail page Route setting is used. On detail page name is get from model route as a string. Detail page has been made within customScrollView. Name details have been showed in SliverAppbar




• Implementation should be done in it's own widget, expected to be called GroupView, which will be receiving the items.
• It should be a single, scrolling widget.
• It should only display valid elements.
• Each element should be tappable, and the next screen should just display the name in detail.
• The widget should be generic, and be able to work with any data type.
• Preferably the widget should use slivers and a customscrollview.
• It should be possible to add a header and footer widget to the list.
• A search field should be available to search and filter the list by name,
