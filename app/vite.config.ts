import { defineConfig } from "vite";

// https://vitejs.dev/config/
export default defineConfig({
  base: "/web-cubeway",
  plugins: [],
  // https://vitejs.dev/config/server-options.html#server-fs-allow
  server: {
    fs: {
      // Allow serving files from one level up to the project root
      allow: [".."],
    },
  },
});
