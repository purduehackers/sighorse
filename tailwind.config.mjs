/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      fontFamily: {
        libertine: ['"Libertinus Serif"', '"Linux Libertine"', 'serif'],
        iosevka: ['"Iosevka Heavy Oblique"', '"Iosevka Curly Hv Ex Obl"', 'Inter', 'sans-serif'],
      },
      aspectRatio: {
        'page': '5.8 / 8.3',
      },
    },
  },
  plugins: [],
};
