import { Controller } from '@hotwired/stimulus'
import { Datepicker } from 'vanillajs-datepicker';

export default class extends Controller {
    static targets = ['checkin', 'checkout'];
    connect() {
        const checkinPicker = new Datepicker(this.checkinTarget, {
            minDate: '11/12/2022'
        });
    }
}