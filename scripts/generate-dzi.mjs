import sharp from 'sharp';
import { readdir, mkdir } from 'fs/promises';
import { existsSync } from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const pagesDir = path.join(__dirname, '../public/pages');
const dziDir = path.join(__dirname, '../public/dzi');

await mkdir(dziDir, { recursive: true });

const files = (await readdir(pagesDir))
  .filter(f => f.endsWith('.jpg'))
  .sort();

console.log(`Generating DZI for ${files.length} pages...`);

const CONCURRENCY = 8;
let done = 0;

async function processFile(file) {
  const name = path.basename(file, '.jpg');
  const outDir = path.join(dziDir, name);
  const dziFile = path.join(dziDir, `${name}.dzi`);

  // Skip if already generated
  if (existsSync(dziFile)) {
    done++;
    process.stdout.write(`\r${done}/${files.length}`);
    return;
  }

  await sharp(path.join(pagesDir, file))
    .tile({
      size: 256,
      overlap: 1,
      layout: 'dz',  // Deep Zoom format
    })
    .toFile(path.join(dziDir, name));  // sharp appends .dzi and _files/

  done++;
  process.stdout.write(`\r${done}/${files.length}`);
}

// Process in batches for concurrency
for (let i = 0; i < files.length; i += CONCURRENCY) {
  const batch = files.slice(i, i + CONCURRENCY);
  await Promise.all(batch.map(processFile));
}

console.log('\nDone!');
