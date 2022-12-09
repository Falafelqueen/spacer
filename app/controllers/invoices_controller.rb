class InvoicesController < ApplicationController
  # before_action :set_client, only: %i[new create]

  def show
    @invoice = Invoice.find(params[:id])
    @garage = @invoice.parking_spaces.first.garage
    if @garage.name.nil?
      @garage.update(name:"#{current_user.first_name}'s garage")
    end
    # @garage = Garage.find(@invoice.parking_spaces.ids.sample)
  end

  def new
    @invoice = Invoice.new
    @garages = current_user.garages
    @client = Client.new
    #if you access from the client_show page to the invoices#new
    @client = Client.find(params[:client_id]) if params[:client_id].present?
  end

  def create
    @invoice = Invoice.new(invoice_params)

    #setting client

    if params[:invoice][:client_id].present?
      @client = Client.find(params[:invoice][:client_id])
    else
      name = params[:invoice][:clients][:first_name]
      last_name = params[:invoice][:clients][:last_name]
      phone_number = params[:invoice][:clients][:phone_number]
      email = params[:invoice][:clients][:email]
      company = params[:invoice][:clients][:company]
      @client = Client.create(user_id: current_user.id, first_name: name, last_name: last_name, phone_number: phone_number, email: email, company: company)
    end
    @invoice.client_id = @client.id

    # adding parking spaces
    parking_spaces = ParkingSpace.find(params[:parking_space])
    @invoice.parking_spaces << parking_spaces

    if @invoice.save!
      # calculating price
      day_difference = (@invoice.end_date - @invoice.start_date).to_i
      number_of_days = day_difference == 0  ? day_difference + 1 : day_difference
      total = parking_spaces.map{ |e| (e.garage.price * number_of_days) if e.garage.price.present? }.sum
      @invoice.update(price: total)
      # creating stripe order
      create_stripe_order(@invoice)
      redirect_to invoice_path(@invoice)
    else
      render :new
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    redirect_to client_path(params[:client_id]), status: :see_other
  end


  private

  # def set_client
  #   @client = Client.find(params[:client_id]) ? Client.find(params[:client_id]) : Client.create()
  # end

  def invoice_params
    params.require(:invoice).permit(:start_date, :end_date, :client_id)
    # params.require(:client).permit(:first_name, :last_name, :phone_number, :email, :company)
  end

  # def client_params
  #   params.require(:invoice).require(:clients).permit(:first_name, :last_name, :phone_number, :email, :company)
  # end

  def create_stripe_order(invoice)
    product = Stripe::Product.create({name:"Parking Spaces Invoice ##{invoice.id} for #{@client.first_name} #{@client.last_name}"})
    price = Stripe::Price.create({currency:"EUR", unit_amount: (invoice.price * 100).to_i, product: product})
    link = Stripe::PaymentLink.create({ line_items: [{ price: price.id, quantity: 1 }, ], })
    @invoice.update(payment_url: link.url)
  end
end
