import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vitest/config';
import tailwindcss from '@tailwindcss/vite';
 

export default defineConfig({
plugins: [tailwindcss(), sveltekit()],
	server: {
		open: true,
		port: 2000,
	},
	test: {
		include: ['src/**/*.{test,spec}.{js,ts}']
	}
});
