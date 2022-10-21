import { Controller } from '@hotwired/stimulus'
import axios from 'axios';

export default class extends Controller {
    favorite() {
        if(this.element.dataset.userLoggedIn === "false") {
           return document.querySelector('[data-header-target="userAuthLink"]').click();
        }
        if(this.element.dataset.favorited === 'true') {
            axios.delete(this.getUnfavoritePath(this.element.dataset.favoriteId), {
                headers: {
                    'ACCEPT': 'application/json'
                }
            }).then((response) => {
                this.element.dataset.favorited = false;
                this.element.setAttribute('fill', '#CED4DA');
            })
        } else {
            axios.post(this.getFavoritePath(), {
                user_id: this.element.dataset.userId,
                property_id: this.element.dataset.propertyId
            }, { headers: {
                'ACCEPT': 'application/json'
            }})
            .then((response) => {
                console.log(response);
                this.element.dataset.favorited = true;
                this.element.setAttribute('fill', 'red');
            });
        }
    }

    getFavoritePath() {
        return '/api/favorites';
    }

    getUnfavoritePath(favoriteId) {
        return `/api/favorites/${favoriteId}`;
    }
}