import { Controller } from '@hotwired/stimulus'
import { getDistance, convertDistance } from 'geolib';
import { isEmpty } from 'lodash-es';

export default class extends Controller {
    static targets = ['property']
    connect() {
        if(isEmpty(this.element.dataset.latitude) && isEmpty(this.element.dataset.longitude)) {
            window.navigator.geolocation.getCurrentPosition((position) => {
                this.element.dataset.latitude = position.coords.latitude
                this.element.dataset.longitude = position.coords.longitude

                const distance = getDistance(
                    { latitude: position.coords.latitude, longitude: position.coords.longitude },
                    { latitude: 61.36031, longitude: -153.71580 }
                )

                const distanceInKm = convertDistance(distance, 'km');
                console.log('distance: ', distanceInKm);

                this.propertyTargets.forEach((propertyTarget) => {
                    let distanceFrom = getDistance(
                        { latitude: position.coords.latitude, longitude: this.element.dataset.longitude},
                        { latitude: propertyTarget.dataset.latitude, longitude: propertyTarget.dataset.longitude} ,
                    );
                    console.log('distanceFrom ', convertDistance(distanceFrom, 'km'));
                    propertyTarget.querySelector('[data-distance-away]').innerHTML = `${Math.ceil(convertDistance(distanceFrom, 'km'))} km away`;
                });
            });
        } else {
            this.propertyTargets.forEach((propertyTarget) => {
                let distanceFrom = getDistance(
                    { latitude: this.element.dataset.latitude, longitude: this.element.dataset.longitude},
                    { latitude: propertyTarget.dataset.latitude, longitude: propertyTarget.dataset.longitude} ,
                );
                console.log('distanceFrom ', convertDistance(distanceFrom, 'km'));
                propertyTarget.querySelector('[data-distance-away]').innerHTML = `${Math.ceil(convertDistance(distanceFrom, 'km'))} km away`;
            });
        }
    }
}