import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  base: './',
  publicDir: './assets', // Serve assets folder in dev mode
  build: {
    outDir: './dist',
    emptyOutDir: true,
    assetsDir: 'assets',
  },
})

