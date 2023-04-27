import { defineConfig } from "vite";
import { wasm } from "@rollup/plugin-wasm";

// https://vitejs.dev/config/
export default defineConfig({
  base: "/hello-wasm",
  plugins: [wasm()],
  // https://vitejs.dev/config/server-options.html#server-fs-allow
  server: {
    fs: {
      // Allow serving files from one level up to the project root
      allow: [".."],
    },
  },
});
