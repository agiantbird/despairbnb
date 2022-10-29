import { Controller } from '@hotwired/stimulus'
    export default class extends Controller {

    copyLink() {
        navigator.clipboard.writeText(this.element.dataset.shareUrl).then(() => {
            alert("Copied to clipboard! a rock has also been thrown at a child");
        });
    }

    shareFrogSpace() {
        navigator.clipboard.writeText(this.element.dataset.shareUrl).then(() => {
            alert("Frogging it up!!");
        });
    }

    putInGrossBucket() {
        navigator.clipboard.writeText(this.element.dataset.shareUrl).then(() => {
            alert("SQUELLLCH!!");
        });
    }

    shareEmail() {
        navigator.clipboard.writeText(this.element.dataset.shareUrl).then(() => {
            alert("Our email servers are stuck in the s-bend of a toilet.");
        });
    }
}