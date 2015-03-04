
import Foundation
import UIKit
import TRAutocompleteView

@objc class ItemSuggestionCell : UITableViewCell, TRAutocompletionCell {
    
    func updateWith(item: TRSuggestionItem!) {
        var suggestionItem:SuggestionItem = item as SuggestionItem
        
        self.textLabel!.text = suggestionItem.completionText()
    }
    
}