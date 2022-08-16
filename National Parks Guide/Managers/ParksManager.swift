//
//  ParksManager.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/10/22.
//

import Foundation
import CoreLocation

//API request for all parks

class NewParksModel {
    func getParks() async throws -> Parks {
        guard let url = URL(string: "https://developer.nps.gov/api/v1/parks?&limit=1000&api_key=\(apiKey)"
) else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(Parks.self, from: data)
        print(url)
        return decodedData
    }
}

//API Request for all parks - used for mapView

class MapParksModel {
    func getParks() async throws -> Parks {
        guard let url = URL(string: "https://developer.nps.gov/api/v1/parks?&limit=1000&api_key=\(apiKey)"
) else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(Parks.self, from: data)
        print(url)
        return decodedData
    }
}

//API request for all parks using search term

class SearchModel: ObservableObject {
    @Published var parks: Parks?
    @Published var fetching: Bool = false
    func fetchSearch(searchTerm: String) {
        fetching = true
        guard let url = URL(string: "https://developer.nps.gov/api/v1/parks?&limit=467&api_key=\(apiKey)&q=\(searchTerm)") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data,
            _, error in
            guard let data = data, error == nil else {
                return
            }
            
            //convert to JSON
            do {
                let parks = try JSONDecoder().decode(Parks.self, from: data)
                DispatchQueue.main.async {
                    self?.parks = parks
                }
                
                print(url)
                
            }
            catch {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
}

struct Parks: Decodable, Hashable {
    var data: [dataResponse]

    struct dataResponse: Decodable, Identifiable, Hashable {
        var id = UUID()
        var fullName: String
        var parkCode: String
        var description: String
        var directionsInfo: String
        var latitude: String
        var longitude: String
        var activities: [activitiesResponse]
        var states: String
        var entranceFees: [entranceFeesResponse]
        var images: [imagesResponse]
        var designation: String
        var operatingHours: [operatingHoursResponse]
         
        struct activitiesResponse: Decodable, Hashable {
            var name: String
        }
        
        struct entranceFeesResponse: Decodable, Hashable, Identifiable {
            let id = UUID()
            var cost: String
            var description: String
            var title: String
        }
        
        struct imagesResponse: Decodable, Hashable {
            var credit: String
            var title: String
            var altText: String
            var caption: String
            var url: String
        }
        
        struct operatingHoursResponse: Decodable, Hashable {
            var exceptions: [exceptionsResponse]?
            var description: String
            var standardHours: standardHoursResponse
            
            struct standardHoursResponse: Decodable, Hashable {
                var monday: String
                var tuesday: String
                var wednesday: String
                var thursday: String
                var friday: String
                var saturday: String
                var sunday: String
                
            }
            
            struct exceptionsResponse: Identifiable, Decodable, Hashable {
                let id = UUID()
                var exceptionHours: exceptionHoursResponse
                var startDate: String?
                var name: String?
                var endDate: String?
                
                struct exceptionHoursResponse: Decodable, Hashable {
                    var monday: String?
                    var tuesday: String?
                    var wednesday: String?
                    var thursday: String?
                    var friday: String?
                    var saturday: String?
                    var sunday: String?
                }
                
            }
            
        }
        
    }
    
}

//API Request for single park

class ParkModel: ObservableObject {
    @Published var onePark: Park?
    func fetchOnePark(parkCode: String) {
        guard let url = URL(string: "https://developer.nps.gov/api/v1/parks?&limit=467&api_key=\(apiKey)&parkCode=\(parkCode)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data,
            _, error in
            guard let data = data, error == nil else {
                return
            }
            
            //convert to JSON
            do {
                let onePark = try JSONDecoder().decode(Park.self, from: data)
                DispatchQueue.main.async {
                    self?.onePark = onePark
                }
                print(url)
                
            }
            catch {
                print(error)

            }
            
        }
        task.resume()
    }
}

struct Park: Decodable, Hashable {
    var data: [dataResponse]

    struct dataResponse: Decodable, Identifiable, Hashable {
        var id = UUID()
        var fullName: String
        var parkCode: String
        var description: String
        var latitude: String
        var longitude: String
        var activities: [activitiesResponse]
        var states: String
        var entranceFees: [entranceFeesResponse]
        var images: [imagesResponse]
        var designation: String
        var operatingHours: [operatingHoursResponse]
         
        struct activitiesResponse: Decodable, Hashable {
            var name: String
        }
        
        struct entranceFeesResponse: Decodable, Hashable {
            var cost: String
            var description: String
            var title: String
        }
        
        struct imagesResponse: Decodable, Hashable {
            var credit: String
            var title: String
            var altText: String
            var caption: String
            var url: String
        }
        
        struct operatingHoursResponse: Decodable, Hashable {
            var exceptions: [exceptionsResponse]?
            var description: String
            var standardHours: standardHoursResponse
            
            struct standardHoursResponse: Decodable, Hashable {
                var monday: String
                var tuesday: String
                var wednesday: String
                var thursday: String
                var friday: String
                var saturday: String
                var sunday: String
                
            }
            
            struct exceptionsResponse: Identifiable, Decodable, Hashable {
                let id = UUID()
                var exceptionHours: exceptionHoursResponse
                var startDate: String?
                var name: String?
                var endDate: String?
                
                struct exceptionHoursResponse: Decodable, Hashable {
                    var monday: String?
                    var tuesday: String?
                    var wednesday: String?
                    var thursday: String?
                    var friday: String?
                    var saturday: String?
                    var sunday: String?
                }
                
            }
            
        }
        
    }
    
}

//API Request for campgrounds

class CampgroundsModel: ObservableObject {
    @Published var campgrounds: Campgrounds?
    func fetchCampgrounds(parkCode: String) {
        guard let url = URL(string: "https://developer.nps.gov/api/v1/campgrounds?&limit=1000&api_key=\(apiKey)&parkCode=\(parkCode)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data,
            _, error in
            guard let data = data, error == nil else {
                return
            }
            
            //convert to JSON
            do {
                let campgrounds = try JSONDecoder().decode(Campgrounds.self, from: data)
                DispatchQueue.main.async {
                    self?.campgrounds = campgrounds
                }
                print(url)
                
            }
            catch {
                print(error)

            }
            
        }
        task.resume()
    }
}

struct Campgrounds: Decodable {
    var data: [dataResponse]

    struct dataResponse: Identifiable, Decodable, Hashable {
        var id = UUID()
        var parkCode: String
        var name: String
        var description: String
        var latitude: String
        var longitude: String
        var reservationInfo: String
        var regulationsOverview: String
        var fees: [feesResponse]
        var images: [imagesResponse]
        var numberOfSitesReservable: String
        var numberOfSitesFirstComeFirstServe: String

        struct feesResponse: Decodable, Hashable {
            var cost: String
            var description: String
            var title: String
        }

        struct imagesResponse: Decodable, Hashable {
            var credit: String
            var title: String
            var caption: String
            var url: String
        }

    }

}

//API Request for things to do


class NewThingsToDoModel {
    func getThingsToDo(parkCode: String) async throws -> ThingsToDo {
        guard let url = URL(string: "https://developer.nps.gov/api/v1/thingstodo?&limit=467&api_key=\(apiKey)&parkCode=\(parkCode)"
) else { fatalError("Missing URL")}
        print(url)
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(ThingsToDo.self, from: data)
        
        return decodedData
    }
    
}


struct ThingsToDo: Decodable, Hashable {
    var data: [dataResponse]

    struct dataResponse: Decodable, Identifiable, Hashable {
        var id = UUID()
        var title: String
        var shortDescription: String
        var images: [imagesResponse]
        var latitude: String
        var longitude: String
        var location: String
        var seasonDescription: String
        var accessibilityInformation: String
        var isReservationRequired: String
        var petsDescription: String
        var timeOfDayDescription: String
        var feeDescription: String
        var age: String
        var arePetsPermittedWithRestrictions: String
        var activityDescription: String
        var locationDescription: String
        var doFeesApply: String
        var longDescription: String
        var reservationDescription: String
        var season: [String]
        var arePetsPermitted: String
        
        struct imagesResponse: Decodable, Hashable {
            var credit: String
            var title: String
            var caption: String
            var description: String
            var url: String
        }
    }
}

//API Request for News Articles

class NewsModel {
    func getArticles() async throws -> News {
        guard let url = URL(string: "https://developer.nps.gov/api/v1/newsreleases?&limit=10&api_key=\(apiKey)"
) else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(News.self, from: data)
        print(url)
        return decodedData
    }
}

//API request for articles specific to park

class ParkNewsModel {
    func getArticles(parkCode: String) async throws -> News {
        guard let url = URL(string: "https://developer.nps.gov/api/v1/newsreleases?&limit=10&api_key=\(apiKey)&parkCode=\(parkCode)"
) else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(News.self, from: data)
        print(url)
        return decodedData
    }
}

struct News: Decodable, Hashable {
    var data: [dataResponse]

    struct dataResponse: Decodable, Identifiable, Hashable {
        var id = UUID()
        var url: String
        var title: String
        var parkCode: String
        var abstract: String
        var relatedParks: [relatedParksResponse]
        var image: imageResponse
         
        struct relatedParksResponse: Decodable, Hashable {
            var states: String
            var fullName: String
        }
        
        struct imageResponse: Decodable, Hashable {
            var url: String
        }
    }
}

//API Request for Alers

class AlertsModel {
    func getAlerts() async throws -> Alerts {
        guard let url = URL(string: "https://developer.nps.gov/api/v1/alerts?&limit=10&api_key=\(apiKey)"
) else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(Alerts.self, from: data)
        print(url)
        return decodedData
    }
}

//API request for alerts specific to park

class ParkAlertsModel {
    func getAlerts(parkCode: String) async throws -> Alerts {
        guard let url = URL(string: "https://developer.nps.gov/api/v1/alerts?&limit=10&api_key=\(apiKey)=\(parkCode)"
) else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(Alerts.self, from: data)
        print(url)
        return decodedData
    }
}

struct Alerts: Decodable, Hashable {
    var data: [dataResponse]

    struct dataResponse: Decodable, Identifiable, Hashable {
        var id = UUID()
        var url: String
        var title: String
        var parkCode: String
        var description: String
        var category: String
        
    }
}

//API request Events for specific park

class ParkEventsModel {
    func getEvents(parkCode: String) async throws -> Events {
        guard let url = URL(string: "https://developer.nps.gov/api/v1/events?&limit=10&api_key=\(apiKey)&parkCode=\(parkCode)"
) else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(Events.self, from: data)
        print(url)
        return decodedData
    }
}

struct Events: Decodable, Hashable {
    var data: [dataResponse]

    struct dataResponse: Decodable, Identifiable, Hashable {
        let id = UUID()
        var location: String
        var title: String
        var description: String
        var category: String
        var times: [timesResponse]
        var types: [String]
        var datestart: String
        var dateend: String
        var infourl: String
        
        struct timesResponse: Decodable, Hashable, Identifiable {
            let id = UUID()
            var timestart: String
            var timeend: String
        }
        
    }
}
