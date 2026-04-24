import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import sharp from 'sharp';
import { readdir, mkdir } from 'fs/promises';
import { existsSync } from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

function generateDzi() {
  async function run(root) {
    const srcDir = path.join(root, 'src/assets/pages');
    const outDir = path.join(root, 'public/dzi');

    if (!existsSync(srcDir)) return;
    await mkdir(outDir, { recursive: true });

    const files = (await readdir(srcDir))
      .filter(f => f.endsWith('.jpg'))
      .sort();

    // Only regenerate if DZI is missing or older than source
    const toProcess = files.filter(f => {
      const name = path.basename(f, '.jpg');
      return !existsSync(path.join(outDir, `${name}.dzi`));
    });

    if (toProcess.length === 0) {
      console.log('[dzi] All DZI files up to date.');
      return;
    }

    console.log(`[dzi] Generating ${toProcess.length} DZI pyramids...`);

    const CONCURRENCY = 8;
    let done = 0;

    async function processFile(file) {
      const name = path.basename(file, '.jpg');
      await sharp(path.join(srcDir, file))
        .tile({ size: 256, overlap: 1, layout: 'dz', quality: 90 })
        .toFile(path.join(outDir, name));
      done++;
      process.stdout.write(`\r[dzi] ${done}/${toProcess.length}`);
    }

    for (let i = 0; i < toProcess.length; i += CONCURRENCY) {
      await Promise.all(toProcess.slice(i, i + CONCURRENCY).map(processFile));
    }
    console.log('\n[dzi] Done.');
  }

  return {
    name: 'generate-dzi',
    hooks: {
      'astro:build:start': ({ logger }) => run(process.cwd()),
      'astro:server:start': ({ logger }) => run(process.cwd()),
    },
  };
}

export default defineConfig({
  integrations: [tailwind(), generateDzi()],
  vite: {
    ssr: { external: ['p5'] },
  },
});
