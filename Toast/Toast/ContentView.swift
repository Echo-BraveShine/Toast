//
//  ContentView.swift
//  Toast
//
//  Created by Brave Shine on 2020/10/30.
//

import SwiftUI


class ContentViewModel: ObservableObject {
    @Published var type : ToastType = .none
}

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
//    @State var type : ToastType = .none
    
    var body: some View {
        
        VStack.init(content: {
          
            
            Text("show activity")
                .onTapGesture(perform: {
                    print("show")
                    self.viewModel.type = .active("loading", 2)
                })
            
            
            Color.red
            
            Spacer()
            
            Text("show text")
                .onTapGesture(perform: {
                    print("show")
                    self.viewModel.type = .message("message", 2)
                })
            Color.red
            Spacer()
            Text("hiden")
                .onTapGesture(perform: {
                    print("hiden")

                    self.viewModel.type = .none
                })
            
        
           
        })
        .background(
            Color.gray
//                .frame(width: 300, height: 300, alignment: .center)
        )
        .toast($viewModel.type)
        
       
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
