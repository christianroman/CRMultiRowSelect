CRMultiRowSelect
============

CRMultiRowSelect is a custom **UITableViewCell** for iOS that supports multiple row selection in a UITableViewController.

Customize the color you want in just one line of code.

Everything is drawn with **CoreGraphics** NO IMAGES, so it supports Retina Display and looks beauty.

![Demo screenshot](https://github.com/chroman/CRMultiRowSelect/raw/master/demo.png)

**Customizable mark colors:**

![Marks screenshot](https://github.com/chroman/CRMultiRowSelect/raw/master/marks.png)

How To Use
----------

 - Add **CRTableViewCell.m** and **CRTableViewCell.h** files to your XCode Project
 - In your **UITableViewController.h** add your 'selected marks' **NSMutableArray**:

```objective-c
@interface YourTableViewController : UITableViewController
{
    NSArray *dataSource;
    NSMutableArray *selectedMarks; // You need probably to save the selected cells for use in the future.
}
```

- Customize your **cellForRowAtIndexPath** method implementation:

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
    
    // init the CRTableViewCell
    CRTableViewCell *cell = (CRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
    }
    
    // Check if the cell is currently selected (marked)
    NSString *text = [dataSource objectAtIndex:[indexPath row]];
    cell.isSelected = [selectedMarks containsObject:text] ? YES : NO;
    cell.textLabel.text = text;
    
    return cell;
}
```

 - Customize your **didSelectRowAtIndexPath** method implementation:

```objective-c
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [dataSource objectAtIndex:[indexPath row]];
    
    if ([selectedMarks containsObject:text])// Is selected?
        [selectedMarks removeObject:text];
    else
        [selectedMarks addObject:text];
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
```

 - You can customize the mark color using a HEX color, just change this line in the **CRTableViewCell.m** file

```objective-c
#define kMarkColor                  kBlueColor // or your HEX color, example: 0xfff000
```

 - Optionally you can get the selected cells using your previous declared **NSMutableArray** (example):

```objective-c
- (void)done:(id)sender
{
    NSLog(@"%@", selectedMarks);
}
```

- Also, you can refer to the Demo Example in the **CRTableViewController.m** file

Requirements
----------
* Xcode 4.3 or higher
* LLVM compiler
* iOS 4.3 or higher
* CoreGraphics Framework
* ARC

## License
Copyright 2012 Christian H. Roman Mendoza / Daniel Rueda Jimenez

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.


Contact me
----------

**Christian Roman**  
  
Website: [http://chroman.me][1]

Contact: [chroman16@gmail.com][2]

Twitter: [http://twitter.com/chroman][3] 

Thanks for the support: Daniel Rueda [Xtr3m0][4]

  [1]: http://chroman.me
  [2]: mailto:chroman16@gmail.com
  [3]: http://twitter.com/chroman
  [4]: http://git.drj.mx/
