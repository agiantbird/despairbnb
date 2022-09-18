import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['email', 'submit'];
    connect() {
        this.submitTarget.addEventListener('click', (e) => {
            e.preventDefault();

            if(this.emailTarget.value.length === 0) {
                console.log('inside if email field is empty')
                //email field is empty so don't do anything
            } else {
                // email field is filled out so do something
                console.log('hey we have content')
            }
        });
    }
}