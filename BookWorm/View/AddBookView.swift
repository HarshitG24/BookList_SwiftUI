//
//  AddBookView.swift
//  BookWorm
//
//  Created by Harshit Gajjar on 5/25/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var mode
    @State var title = ""
    @State var author = ""
    @State var rating = 3
    @State var genre = ""
    @State var review = ""
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name of Book", text: $title)
                    TextField("Name of author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genreData, id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section{
                    Picker("Rating", selection: $rating) {
                        ForEach(0..<6, id: \.self){
                            Text("\($0)")
                        }
                    }
                    
                    TextField("Write a review", text: $review)
                }
                
                Section{
                    Button("Save"){
                        let book = Book(context: self.moc)
                        book.id = UUID()
                        book.title = "\(self.title)"
                        book.genre = "\(self.genre)"
                        book.rating = Int16(self.rating)
                        book.author = "\(self.author)"
                        book.review = "\(self.review)"
                        
                        try? self.moc.save()
                        self.mode.wrappedValue.dismiss()
                    }
                }
            }.navigationBarTitle("Add Book", displayMode: .inline)
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
