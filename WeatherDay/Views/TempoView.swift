import SwiftUI

//Tela que exibe informações meteorológicas formatadas em um layout especifico
struct TempoView: View {
    // Dados meteorológicos recebidos
    var weather: ResponseBody
    // Dicionário vazio para guardar as condições climáticas
    var condition: [String: [Double]] = [:]
    
        // Função que determina o simbolo correspondente a cada condição climática
        func weatherSymbol(for condition: String) -> String {
            // Switch para mapear as condições climáticas para os simbolos
            switch condition {
            case "Clear":
                return "sun.max.fill"
            case "Clouds":
                return "cloud.fill"
            case "Rain":
                return "cloud.rain.fill"
            case "Snow":
                return "snow"
            case "Drizzle":
                return "cloud.drizzle.fill"
            case "Thunderstorm":
                return "cloud.bolt.fill"
            case "Fog":
                return "cloud.fog.fill"
            case "Mist":
                return "Cloud.fog"
            default:
                return "Desconhecido"
            }
        }
    
    var body: some View {
        ZStack(alignment: .leading){
            // Fundo gradiente
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan, Color.blue]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .preferredColorScheme(.dark)
            VStack{
                VStack(alignment: .leading, spacing: 5) {
                    // Localização como título
                    Text(weather.name)
                        .bold().font(.title)
                    // Indica a data e hora atual
                    Text("Hoje, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack{
                    HStack{
                        VStack(spacing: 20){
                            // Ícone e descrição da condição climática atual
                            Image(systemName: weatherSymbol(for: weather.weather[0].main))
                                .font(.system(size: 90))
                            Text(weather.weather[0].main)
                                .bold()
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        // Temperatura "sensação térmica" atual
                        Text(weather.main.feels_like.roundDouble() + "º")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack{
                Spacer()
                VStack(alignment: .leading, spacing: 20){
                    // Título para a divisão sobre as informações meteorológicas
                    Text("Informações Meteorológicas")
                        .bold().padding(.bottom)
                    
                    /** 
                     Exibe as informações:
                     - Temperatura mínima,
                     - Temperatura máxima,
                     - Humidade,
                     - Vento,
                     - Temperatura Térmica,
                     - Pressão
                    **/
                    
                    HStack{
                        FeelsLike(icon: "sun.min.fill", nome: "Temp Min", valor: (weather.main.tempMin.roundDouble() + "º"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        FeelsLike(icon: "sun.max.fill", nome: "Temp Max", valor: (weather.main.tempMax.roundDouble() + "º"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                
                    }
                    HStack{
                        FeelsLike(icon: "humidity.fill", nome: "Humidade", valor: (weather.main.humidity.roundDouble() + "%"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        FeelsLike(icon: "wind", nome: "Vento", valor: (weather.wind.speed.roundDouble() + " m/s"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack{
                        FeelsLike(icon: "thermometer.transmission", nome: "Temp Térmica", valor: (weather.main.feels_like.roundDouble() + "º"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        FeelsLike(icon: "gauge", nome: "Pressão", valor: (weather.main.pressure.roundDouble() + " hPa"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 40)
                .foregroundColor(.white)
                .background(.black)
                .opacity(0.7)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .preferredColorScheme(.dark)
    }
}


#Preview {
    // Previsualização da tela de informações meteorológicas com os dados de previsão carregados
    TempoView(weather: previewTempo)
}
