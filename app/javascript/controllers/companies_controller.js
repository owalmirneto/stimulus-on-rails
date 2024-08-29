import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = [
		"cnpj",
		"companyName",
		"tradingName",
		"email",
		"phoneNumber",
		"zipCode",
		"streetName",
		"addressNumber",
		"neighborhood",
		"city",
		"state",
	];

	async fetch(event) {

		const cleanCNPJ = event.target.value.replace(/\D/g, "");

		if (cleanCNPJ.length !== 14) return;
		console.log(event.target.value);

		fetch(`/companies/${cleanCNPJ}.json`)
			.then((response) => response.json())
			.then((response) => {
				this.cityTarget.value = response.city;
				this.stateTarget.value = response.state;
				this.companyNameTarget.value = response.companyName;
				this.tradingNameTarget.value = response.tradingName;
				this.zipCodeTarget.value = response.zipCode;
				this.streetNameTarget.value = response.streetName;
				this.addressNumberTarget.value = response.addressNumber;
				this.neighborhoodTarget.value = response.neighborhood;
				this.emailTarget.value = response.email;
				this.phoneNumberTarget.value = response.phoneNumber;
			});
	}
}
