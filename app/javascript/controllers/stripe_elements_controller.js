import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    submitButtonClass = "mt-4 w-full bg-indigo-600 border border-transparent rounded-md font-medium shadow-sm py-3 px-4 text-white";
    connect() {
        this.getStripeFormLabel().className += 'hidden mt-4';
        this.getStripeSubmitButton().className += this.submitButtonClass;
    }

    getStripeSubmitButton() {
        return document.querySelector('#stripe-form input[type="submit"]')
    }

    getStripeFormLabel() {
        return document.querySelector('label[for="card_element"]');
    }
}