//
//  CardsStackView.swift
//  FlashCards
//
//  Created by Дарья Леонова on 22.07.2022.
//

import SwiftUI

struct CardsStackView: View {
    @State var cards = [
        Card(id: 0, question: "1", answer: "🔥"),
        Card(id: 1, question: "2", answer: "👍"),
        Card(id: 2, question: "3", answer: "😂"),
        Card(id: 3, question: "4", answer: "❤️")
    ]
             
    private var maxID: Int {
        cards.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                ForEach(cards, id: \.question) { card in
                    if (maxID - 1)...maxID ~= card.id {
                        CardView(card: card, onRemove: { removableCard in
                            self.cards.removeAll { $0.id == removableCard.id}
                        })
                        .frame(
                            width: getCardWidth(geometry, id: card.id),
                            height: 400
                        )
                        .offset(
                            x: 0,
                            y: getCardOffset(geometry, id: card.id)
                        )
                    }
                }
            }
        }
    }
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(cards.count - 1 - id) * 10
        let result = geometry.size.width - offset
        guard result > 0 else {
            return 0
        }
        return geometry.size.width - offset
    }
    
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(cards.count - 1 - id) * 16
    }
}

struct CardsStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardsStackView()
    }
}
