import SwiftUI

struct FeelsLike: View {
    
    var icon: String
    var nome: String
    var valor: String
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                .cornerRadius(50)
            
            VStack{
                Text(nome)
                    .font(.caption)
                Text(valor)
                    .bold()
                    .font(.title)
            }
        }
    }
}

#Preview {
    FeelsLike(icon: "thermometer", nome: "Feels like", valor: "º")
}
