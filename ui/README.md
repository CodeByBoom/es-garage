# ES Garage UI

Modern, responsive garage UI built with **Vue 3 + Vite + Bun**.

> 📖 **Full documentation:** See the main [README.md](../README.md)

---

## Quick Start

### Development Mode (Live Preview)

```bash
cd ui
bun install
bun run dev
```

Open http://localhost:5173 in your browser!

**Features:**
- ✅ Hot reload - See changes instantly
- ✅ Mock data - Auto-loads 6 test vehicles
- ✅ Real images - Uses actual vehicle PNGs
- ✅ No FiveM needed - Test in browser

### Production Build

```bash
bun run build
```

Output: `dist/` folder (used by FiveM)

**After building:**
```
restart es-garage
```

---

## Project Structure

```
ui/
├── assets/
│   └── car/              ← 775 vehicle images
├── dist/                 ← Build output (auto-generated)
├── src/
│   ├── App.vue          ← Main UI component
│   ├── style.css        ← Styling
│   ├── main.js          ← Vue initialization
│   └── mock-data.js     ← Dev mode test data
├── package.json
├── vite.config.js
└── index.html
```

---

## Making Changes

1. **Edit** `src/App.vue` or `src/style.css`
2. **Save** - Browser auto-refreshes
3. **Build** when ready: `bun run build`
4. **Restart** resource in-game

---

## Tech Stack

- **Vue 3** - Composition API
- **Vite** - Build tool
- **Bun** - Runtime & package manager

---

For full documentation, see [README.md](../README.md)
