# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


require "date"

Invoice.destroy_all
User.destroy_all
Client.destroy_all
Garage.destroy_all
ParkingSpace.destroy_all
InvoiceSpace.destroy_all


puts "Creating users..."
user1 = User.create(email:"info1@info.com", encrypted_password: "rkgjbsdalkfbsafkab", password: "123456", first_name: "Stefan", last_name: "Alexandru", company: "Auchan", vat_number: "12345", address: "rue des brucs 15", country: "spain", phone_number: "695489859")
user2 = User.create(email:"info@info.com", encrypted_password: "rkgjbsdalkfbsafkab", password: "123456", first_name: "Robert", last_name: "Muller", company: "Hornbach", vat_number: "34567", address: "rue de la foret, 3", country: "luxembourg", phone_number: "691345")
user3 = User.create(email:"info3@info.com", encrypted_password: "rkgjbsdalkfbsafkab", password: "123456", first_name: "Mathis", last_name: "Krier", company: "Condis", vat_number: "5678", address: "rue des miguels, 3", country: "romania", phone_number: "691115147")
user4 = User.create(email:"info4@info.com", encrypted_password: "rkgjbsdalkfbsafkab", password: "123456", first_name: "Gerard", last_name: "Mota", company: "BlueSpot", vat_number: "76543", address: "rue des petasses 15", country: "portugal", phone_number: "4564455")
user5 = User.create(email:"info5@info.com", encrypted_password: "rkgjbsdalkfbsafkab", password: "123456", first_name: "John", last_name: "Doe", company: "Ruetz", vat_number: "345679", address: "rue des conasses, 55", country: "denmark", phone_number: "422422")

puts "Users created"
puts "Creatings garages..."

garage1 = Garage.create(name: "Oldtown Garage", location: "New York", price: 10, average_size: 12, description: "in very good shape", capacity:5, user_id:1 )
garage2 = Garage.create(name: "Exclusiv Garage", location: "Boston", price: 15, average_size: 13, description: "good shape", capacity:30, user_id: 2 )
garage3 = Garage.create(name: "Rusty Garage", location: "Detroit", price: 13, average_size: 13, description: "bad condition", capacity:25, user_id: 3)
garage4 = Garage.create(name: "Skyscrapper Garage", location: "Chicago", price: 14, average_size: 12, description: "good condition", capacity:33, user_id: 4)
garage5 = Garage.create(name: "Village Garage", location: "LA", price: 11, average_size: 11, description: "very good!!!!", capacity:7, user_id: 5)

puts "Garages created"
puts "Creatings parkingspaces..."

parkingspace1 = ParkingSpace.create(custom_size: 12, custom_price: 120, title: "babygarage", garage_id: 1)
parkingspace2 = ParkingSpace.create(custom_size: 13, custom_price: 110, title: "exclusive garage", garage_id: 2)
parkingspace3 = ParkingSpace.create(custom_size: 7, custom_price: 10, title: "bikegarage", garage_id: 3)
parkingspace4 = ParkingSpace.create(custom_size: 9, custom_price: 75, title: "motobike", garage_id: 4)
parkingspace5 = ParkingSpace.create(custom_size: 8, custom_price: 80, title: "yacht", garage_id: 5)

puts "parkingspaces created"

puts "Creatings clients.."

client1 = Client.create!(first_name: "Bob", last_name: "Schmit", phone_number: "691115147" , email: "bob.schmit@gmail.com", company: "nordica", user_id: 1)
client2 = Client.create(first_name: "Daniel", last_name: "Biren", phone_number: "6912345147" , email: "daniel.biren@gmail.com", company: "scarpa", user_id: 2)
client3 = Client.create(first_name: "Joe", last_name: "Koster", phone_number: "69387363" , email: "joekoster@gmail.com", company: "atomic", user_id: 3)
client4 = Client.create(first_name: "Luc", last_name: "Welter", phone_number: "6453345" , email: "luc.welter@gmail.com", company: "k2", user_id: 4 )
client5 = Client.create(first_name: "Robert", last_name: "Müller", phone_number: "1000000" , email: "roby.muller@ping.com", company: "bbc", user_id: 5)

puts "Clients created"

puts "Creatings invoices.."
invoice1= Invoice.create(start_date: "01/01/2021", end_date: "01/01/2023",price: 10,payment_confirmed: 1, client_id: 1)
invoice2= Invoice.create(start_date: "01/03/2021", end_date: "01/05/2024",price: 11,payment_confirmed: 0, client_id: 2)
invoice3= Invoice.create(start_date: "03/02/2022", end_date: "01/12/2022",price: 12,payment_confirmed: 1, client_id: 3)
invoice4= Invoice.create(start_date: "09/07/2022", end_date: "01/03/2025",price: 12,payment_confirmed: 1, client_id: 4)
invoice5= Invoice.create(start_date: "01/03/2023", end_date: "01/05/2027",price: 60,payment_confirmed: 1, client_id: 5)

puts "Invoices created"


puts "Creatings invoicespace.."
invoice_space1 = InvoiceSpace.create(parking_space_id: 1, invoice_id: 1)
invoice_space2 = InvoiceSpace.create(parking_space_id: 2, invoice_id: 3)
invoice_space3 = InvoiceSpace.create(parking_space_id: 3, invoice_id: 2)
invoice_space4 = InvoiceSpace.create(parking_space_id: 4, invoice_id: 4)
invoice_space5 = InvoiceSpace.create(parking_space_id: 5, invoice_id: 5)

puts "Invoice_spaces created"
