import { Controller } from "@hotwired/stimulus"
import axios from 'axios';

export default class extends Controller {
    static targets = ['email', 'submit', 'errorMessage'];
    connect() {
        console.log('axios: ', axios)
        this.submitTarget.addEventListener('click', (e) => {
            e.preventDefault();

            if(this.emailTarget.value.length === 0) {
                console.log('inside if email field is empty')
                this.emailTarget.classList.add('invalid-inset-input-text-field');
                this.emailTarget.classList.remove('border-gray-200');
                this.errorMessageTarget.classList.remove('hidden');
            } else {
                axios.get('/api/users_by_email', {
                    params: {
                        email: this.emailTarget.value
                    },
                    headers : {
                        'ACCEPT': 'application/json'
                    }
                }).then((response) => {
                    Turbo.visit('/users/sign_in');
                }).catch((response) => {
                    Turbo.visit('/users/sign_up');
                })
            }
        });
    }
}