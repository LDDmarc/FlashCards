//
//  CardView.swift
//  FlashCards
//
//  Created by Дарья Леонова on 22.07.2022.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var onRemove: (_ card: Card) -> Void
    
    @State private var flipped = false
    @State private var rotate = false
    
    @State private var translation: CGSize = .zero
    
    private let removePercentrageValue = 0.5
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(radius: 5)
                    .frame(maxHeight: 400)
                
                if flipped {
                    Text(card.answer)
                        .font(.title2)
                        .rotation3DEffect(
                            Angle(degrees: 180),
                            axis: (x: 0, y: 1, z: 0)
                        )
                } else {
                    Text(card.question)
                        .font(.title2)
                }
            }
            .padding()
            .offset(x: translation.width, y: 0)
            .modifier(FlipEffect(
                flipped: $flipped,
                angle: rotate ? 180 : 0,
                axis: (x: 0, y: 1)
            ))
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1.0)) {
                    rotate.toggle()
                }
            }
            .rotationEffect(
                .degrees(flipped ? -getDegrees(geometry) : getDegrees(geometry)),
                anchor: .bottom
            )
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        var newTranslation = value.translation
                        if flipped {
                            newTranslation = CGSize(width: -value.translation.width, height: -value.translation.height)
                        }
                        self.translation = newTranslation
                    }
                    .onEnded{ value in
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.removePercentrageValue {
                            self.onRemove(self.card)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    private func getDegrees(_  geometry: GeometryProxy) -> Double {
        Double(translation.width / geometry.size.width) * 25
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(
            id: 0,
            question: "Queue?",
            answer: "Last"
        )
        NavigationView {
            CardView(card: card, onRemove: { _ in
                
            })
        }
    }
}
