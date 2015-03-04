
import Foundation
import TRAutocompleteView

@objc class SuggestionItem : NSObject, TRSuggestionItem {
    
    var suggestionText:String
    
    init(suggestionText:String) {
        self.suggestionText = suggestionText
    }
    
    class func withText(text:String) -> SuggestionItem {
        var s:SuggestionItem = SuggestionItem(suggestionText:text)
        return s
    }
    
    func completionText() -> String! {
        return self.suggestionText
    }
    
}
