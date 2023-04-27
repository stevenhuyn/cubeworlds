# 3D Conway Implementation - WASM Compatible

```bash
wasm-pack build --target web --out-dir app/pkg
```

Add to vscode workspace json settings

```json
{
  "rust-analyzer.cargo.extraEnv": {
    "RUSTFLAGS": "--cfg rust_analyzer"
  }
}
```
