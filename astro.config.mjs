import { defineConfig } from 'astro/config';
import { generateDzi } from './src/plugins/2025-postlaunch-dzi.mjs';

export default defineConfig({
  integrations: [generateDzi()],
  redirects: {
    '/': '/2025-postlaunch',
    '/pages': '/2025-postlaunch/pages',
  },
  vite: {
    ssr: { external: ['p5'] },
  },
});
