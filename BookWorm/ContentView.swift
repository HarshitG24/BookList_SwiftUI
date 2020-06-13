//
//  ContentView.swift
//  BookWorm
//
//  Created by Harshit Gajjar on 5/25/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books, id: \.self){ book in
                    NavigationLink(destination: Text(book.title ?? "unknown")) {
                        
                        VStack(alignment: .leading){
                            Text(book.title ?? "unknown")
                                .font(.headline)
                        }
                    }
                }.onDelete{index in
                    let deleteItem = self.books[index.first!]
                    self.moc.delete(deleteItem)
                    
                    do{
                        try self.moc.save()
                    }catch{
                        print(error)
                    }
                }
            }
            .navigationBarTitle("BookWorm")
                .navigationBarItems(trailing: Button(action:{
                    self.showingAddScreen.toggle()
                }){
                    Image(systemName: "plus")
                }
            ).sheet(isPresented: $showingAddScreen){
                AddBookView().environment(\.managedObjectContext, self.moc)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
