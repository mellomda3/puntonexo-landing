# Sync landing — 3 copias

| Copia | Rama | Push a GitHub |
|-------|------|---------------|
| `PuntoNexo-Dev\puntonexo-landing` | `dev/cursor` | No (vía `C:\Projects`) |
| `C:\Projects\puntonexo-landing` | `main` | Sí |
| GitHub | `main` | GitHub Pages → puntonexo.mello.com.ar |

## Publicar cambios

```powershell
cd C:\Users\Christian\Projects\PuntoNexo-Dev\puntonexo-landing
git add -A
git commit -m "..."
.\scripts\sync-to-github.ps1
```

El script: `dev/cursor` → `C:\Projects` → merge `main` → push GitHub → deploy automático (Actions + Pages).

## Remotes en Dev (no tocar a mano)

- `origin` → `C:\Projects\puntonexo-landing` (push de trabajo)
- `github` → fetch de `mellomda3/puntonexo-landing`
