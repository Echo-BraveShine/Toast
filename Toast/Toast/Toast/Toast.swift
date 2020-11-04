//
//  Toast.swift
//  Toast
//
//  Created by Brave Shine on 2020/10/30.
//
import SwiftUI
import Foundation

enum ToastType: Equatable {
    case none
    case message(String?,TimeInterval? = nil)
    case active(String?,TimeInterval? = nil)
}


extension View{
   
    func toast(_ type : Binding<ToastType>) -> some View{
        modifier(ToastModifier.init(type: type))
//        return ModifiedContent.init(content: self, modifier: ToastModifier.init(type: type))
    }
    
    func anyView() -> AnyView {
        return AnyView(self)
    }
}


struct ToastModifier: ViewModifier {
    @Binding var type: ToastType
        
    init(type: Binding<ToastType> ) {
        self._type = type
    }
   
    func body(content: Content) -> some View {
        
        if case ToastType.none = type{
            return content.anyView()
        }else{
          return ZStack.init(alignment: .center) {
                content
            ToastView.init(type: $type)
          }.anyView()
        }
        
    }
}

struct ToastView: View {
    
    @Binding var type: ToastType
    
    init(type: Binding<ToastType>) {
        self._type = type
        hiden(toastType: type.wrappedValue)
    }
    
    var body: some View  {
        ZStack.init(content: {
            if case ToastType.active(let text, _) = self.type{
                VStack{
                    ActivityView()
                    if let t = text{
                        Text(t)
                            .foregroundColor(Color.white)
                    }
                }
                
            }else if case ToastType.message(let text, _) = self.type{
                if let t = text{
                    Text(t)
                        .foregroundColor(Color.white)
                }else{
                    
                }
            }
        })
        .padding(.all, 10)
        .background(
            
            Color.black
                .blur(radius: 5,opaque:true)
        )
        .cornerRadius(5)
    }

    func hiden(toastType: ToastType){

        func hiden(after duration: Double?){
            if let t = duration{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                    if toastType == type{
                        self.type = .none
                    }
                }
            }
        }
        if case ToastType.active(_, let duration) = type{
            hiden(after: duration)

        }else if case ToastType.message(let text, let duration) = type{
            if text == nil || text?.count == 0 {
                hiden(after: 0)
            }else{
                hiden(after: duration ?? 2)
            }
        }
    }

}

struct ActivityView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView()
        v.color = .white
        return v
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }

    typealias UIViewType = UIActivityIndicatorView
}
