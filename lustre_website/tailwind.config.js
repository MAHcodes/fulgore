/** @type {import('tailwindcss').Config} */
export default {
	content: ["./index.html", "./src/**/*.gleam"],
	theme: {
		extend: {
			container: {
				center: true,
				padding: "1rem",
			},
			fontFamily: {
				primary: "Poppins, Arial, sans-serif",
			},
			fontSize: {
				sm: "var(--fz-sm)",
				base: "var(--fz-base)",
				md: "var(--fz-md)",
				lg: "var(--fz-lg)",
				xl: "var(--fz-xl)",
				"2xl": "var(--fz-2xl)",
				"3xl": "var(--fz-3xl)",
			},
			colors: {
				aquamarine: "#85F6E3",
				vodka: "#B4BEFD",
				mauve: "#D8BBFE",
				blond: "#FEEBBB",
				"bright-gray": "#EAECF0",
				"dim-gray": "#6B6D6B",
				"dark-charcoal": "#322933",
			},
		},
	},
	plugins: [],
};
