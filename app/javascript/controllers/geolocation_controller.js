import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    connect() {
        console.log('this.element: ', this.element);
        window.navigator.geolocation.getCurrentPosition((position) => {
            this.element.dataset.latitude = position.coords.latitude
            this.element.dataset.longitude = position.coords.longitude
        });
    }
}