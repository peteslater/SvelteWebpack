import Header from './Header.svelte';

const header = new Header({
	target: document.querySelector('header'),
	props: {
		name: 'Svelte Webpack Header'
	}
});

export default header;
