import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isActive = false
    
    let levels = ["Easy", "Medium", "Hard"]
    let colors = [Color.green, Color.orange, Color.red]
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Text("Guess by emoji")
                    .bold()
                    .font(.title)
                
                ScrollView(showsIndicators: false) {
                    
                    ForEach(0..<levels.count, id: \.self) { index in
                        
                        NavigationLink {
                            GameView(level: levels[index]).onAppear {
                                model.movies.shuffle()
                                model.resetGuessed()
                                model.timeRemaining = 60
                            }
                        } label: {
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(colors[index])
                                    .frame(height: 150)
                                
                                Text(levels[index])
                                    .bold()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .tint(.black)
            .navigationBarHidden(true)
            .navigationViewStyle(.stack)
        }
    }
}
