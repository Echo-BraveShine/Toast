//
//  ContentView.swift
//  Toast
//
//  Created by Brave Shine on 2020/10/30.
//

import SwiftUI

struct ContentView: View {
    
    @State var type : ToastType = .none
    
    var body: some View {
        
        VStack.init(content: {
            Color.white
                .frame(width: 300, height: 300, alignment: .center)
            
            Text("show activity")
                .onTapGesture(perform: {
                    print("show")
                    type = .active(nil, 2)
                })
            
            Text("show text")
                .onTapGesture(perform: {
                    print("show")
                    type = .message(nil, 2)
                })
            
            Text("hiden")
                .onTapGesture(perform: {
                    print("hiden")

                    type = .none
                })
            
        
           
        })
        .toast($type)
        
       
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
