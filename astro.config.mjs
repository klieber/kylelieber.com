import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://kylelieber.com',
  trailingSlash: 'always',
  build: {
    format: 'directory'
  }
});
