import { Controller } from '@hotwired/stimulus'
import { Datepicker } from 'vanillajs-datepicker';

export default class extends Controller {
    static targets = ['checkin', 'checkout']
    connect() {
        const checkinPicker = new Datepicker(this.checkinTarget, {
            minDate: this.element.dataset.defaultCheckinDate
        });

        const checkoutPicker = new Datepicker(this.checkoutTarget, {
            minDate: this.element.dataset.defaultCheckoutDate
        });
    }
}