//
//  Home.swift
//  UI-605
//
//  Created by nyannyan0328 on 2022/07/05.
//

import SwiftUI

struct Home: View {
    @State var selectedPizza : Pizza = pizzas[0]
    
    @State var  swipeDelection : Alignment = .center
    @State var animatedPizza : Bool = false
    @State var pizzaSize : String = "SMALL"
    @Namespace var animation
    
    var body: some View {
        VStack{
            
            HStack{
                
                Button {
                    
                } label: {
                    
                    Image("Menu")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:20,height: 20)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    
                    Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:60,height: 60)
                        .clipShape(Circle())
                    
                }


            }
            .overlay {
                Text(attString)
                    .font(.title)
                    .foregroundColor(.orange)
                    
            }
            
            
            Text("Selected Youre Pizza".uppercased())
                .font(.callout.weight(.light))
                .kerning(1.5)
            
            AnimatedSlider()
            
            
            
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background{
            
       
         
            Color("BG").ignoresSafeArea()
          
        }
        
    }
    
    @ViewBuilder
    func AnimatedSlider() -> some View{
        
        GeometryReader{proxy in
            
             let size = proxy.size
            
            LazyHStack(spacing:0){
                
                
                
                
                ForEach(pizzas){piza in
                    
                    let index = getIndex(pizza: piza)

                    let mainIndex = getIndex(pizza: selectedPizza)
                    
                    VStack(spacing:10){
                        
                        
                        Text(piza.pizzaTitle)
                            .font(.largeTitle.weight(.black))
                        
                        Text(piza.pizzaDescription)
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.horizontal)
                            .padding(.top)
                    }
                    .frame(width: size.width,height: size.height,alignment: .top)
                    .rotationEffect(.init(degrees: mainIndex == index ? 0 : (index > mainIndex ? 180 : -180)))
                    .offset(x:-CGFloat(mainIndex) * size.width,y:index == mainIndex ? 0 : 40)
                }
               
                
            
                
                
            }
          
            PizzaView()
                .padding(.top,120)
           
            
        }
        .padding(-15)
        .padding(.top,35)
        
     
        
        
        
    }
    
    @ViewBuilder
    func PizzaView()->some View{
        
        GeometryReader{proxy in
            
             let size = proxy.size
            
            ZStack(alignment:.top){
            
                
                Image(selectedPizza.pizzaImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:size.width)
                    .offset(y:75)
                
                
                
                
                if pizzas.first?.id != selectedPizza.id{
                    
                    
                      Arishape()
                          .trim(from: 0.05,to:0.3)
                          .stroke(.gray,lineWidth: 1)
                          .offset(y:75)
                      
                      
                      Image(systemName: "chevron.left")
                          .rotationEffect(.init(degrees: -30))
                          .offset(x:-(size.width / 2) + 30,y:55)
                      
                    
                }
           
                
                if pizzas.last?.id != selectedPizza.id{
                    
                    
                    Arishape()
                        .trim(from: 0.7,to:0.95)
                        .stroke(.gray,lineWidth: 1)
                        .offset(y:75)
                    
                    
                    Image(systemName: "chevron.right")
                        .rotationEffect(.init(degrees: 30))
                        .offset(x:(size.width / 2) - 30,y:55)
                }
                
                Text(priceAttString(value:selectedPizza.pizzaPrice))
                    .font(.largeTitle.weight(.black))
            
                    
                
            }
            .rotationEffect(.init(degrees: animatedPizza ? (swipeDelection == .leading ? -360 : 360) : 0))
            .offset(y:size.height / 2)
            .gesture(
            
            DragGesture()
                .onEnded{value in
                    
                    let index = getIndex(pizza: selectedPizza)
                    let translation = value.translation.width
                    
                    
                    if translation < 0 && -translation > 50 && index != (pizzas.count - 1){
                        
                        swipeDelection = .leading
                        hadleSwip()
                    }
                    
                    if translation > 0 && translation > 50 && index > 0{
                        swipeDelection = .trailing
                        hadleSwip()
                    }
                }
            )
            
            HStack{
                
                ForEach(["SMALL","MEDIUM","LARGE"],id:\.self){text in
                    
                    
                    Text(text)
                        .font(.callout)
                        .foregroundColor(pizzaSize == text ? .red : .gray)
                        .overlay(content: {
                            
                            
                            if pizzaSize == text{
                                
                               Circle()
                                    .fill(.red)
                                    .frame(width:15,height:15)
                                    .offset(y:25)
                                    .matchedGeometryEffect(id: "SIZETAB", in: animation)
                            }
                        })
                        .frame(maxWidth: .infinity,alignment: .center)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            
                            withAnimation{
                                
                                pizzaSize = text
                            }
                        }
                }
            }
            .padding(.vertical)
            .background{
             
                ZStack(alignment:.top){
                    
                    Rectangle()
                        .trim(from: 0.25,to: 1)
                        .stroke(.gray,lineWidth: 1)
                    
                    Rectangle()
                        .trim(from: 0,to: 0.17)
                        .stroke(.gray,lineWidth: 1)
                    
                    Text("SIZE")
                        .font(.caption2)
                        .offset(x:-5,y:-5)
                }
            }
        }
        
    }
    
    func hadleSwip(){
        
        let index = getIndex(pizza: selectedPizza)
        
        if swipeDelection == .leading{
            
            withAnimation(.easeInOut(duration: 0.9)){
                
                
                selectedPizza = pizzas[index + 1]
                animatedPizza = true
            }
            
        }
        if swipeDelection == .trailing{
            
            withAnimation(.easeInOut(duration: 0.9)){
                
                
                selectedPizza = pizzas[index - 1]
                animatedPizza = true
                
            }
            
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            
       
                
                animatedPizza = false
            
            
            
        }
    }
    var attString : AttributedString{
        
        var str = AttributedString(stringLiteral: "EATPIZZA")
        
        if let range = str.range(of: "PIZZA"){
            
            str[range].foregroundColor = .gray
        }
        return str
    }
    
    func getIndex(pizza : Pizza)->Int{
        
        return pizzas.firstIndex { CAZZA in
            CAZZA.id == pizza.id
        } ?? 0
    }
    
    func priceAttString(value : String)->AttributedString{
        
        var str = AttributedString(stringLiteral: value)
        
        if let range =  str.range(of: "$"){
            
            
            str[range].font = .system(size: 20)
        }
        
        return str
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
