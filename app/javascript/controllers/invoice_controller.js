import { Controller } from "@hotwired/stimulus"

let total = 0
export default class extends Controller {
  static targets = ["spaces", "checkbox", "price", "startDate", "garage"]
  connect() {
    console.log("connected to");
  }

  filterGarage(event){
    const garage_id = event.currentTarget.value
    this.getLots(garage_id)
  }

  previewPrice(event){
    const parking_spot = event.currentTarget
    const range = this.startDateTarget.value.replaceAll(/\s/g,'').split("to")
    const start = new Date(range[0]).getDate()
    let end = start
    if(range[1]){
     end = new Date(range[1]).getDate()
    }
    const duration = (end - start)
    const parking_price = Number(parking_spot.dataset.price)

    // checking if the duration is returning NaN, if not calculate price preview->
    if(!Number.isNaN(duration)){
      if(event.currentTarget.checked){
        total = total + (parking_price * duration)
      }else{
        total = total - (parking_price * duration)
      }
    }
    this.priceTarget.innerHTML = total
    return total
  }

  filterDates(event){
    const garage_id= this.garageTarget.value;
    const range = event.currentTarget.value.replaceAll(/\s/g,'').split("to")
    const first_day = range[0]
    const end_day = range.length == 2 ? range[1] : first_day
    this.getLots(garage_id, first_day, end_day)
  }

  getLots(garage_id, start_date, end_date) {
    const params = {
      garage_id: garage_id,
      start_date: start_date,
      end_date: end_date
    }

    let url = "/parking_spaces?"

    Object.keys(params).forEach(key => {
      if(![null, undefined, ''].includes(params[key])){
        url += `${key}=${params[key]}&`
      }
    })

    fetch(url)
    .then(response => response.text())
    .then(data => {
      this.spacesTarget.innerHTML = data
    }

    )
  }

}
