import { defineConfig, fontProviders } from 'astro/config';
import { generateDzi } from './src/plugins/2025-postlaunch-dzi.mjs';

export default defineConfig({
  integrations: [generateDzi()],
  redirects: {
    '/': '/2026-prelaunch',
    '/pages': '/2025-postlaunch/pages',
  },
  fonts: [
    {
      provider: fontProviders.local(),
      name: 'SourceSerif4',
      cssVariable: '--font-source-serif-4',
      options: {
        variants: [
          {
            src: ['./src/fonts/SourceSerif4-VariableFont_opsz,wght.ttf'],
            weight: '200 900',
            style: 'normal',
          },
          {
            src: ['./src/fonts/SourceSerif4-Italic-VariableFont_opsz,wght.ttf'],
            weight: '200 900',
            style: 'italic',
          },
        ],
      },
    },
  ],
  vite: {
    ssr: { external: ['p5'] },
  },
});
