import App from './App.svelte';

const app = new App({
	target: document.querySelector('body'),
	props: {
		message: 'Press a button !!!'
	}
});

export default app;
