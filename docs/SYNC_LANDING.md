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

## Si falla «pages build and deployment»

El workflow automático de GitHub a veces marca error en **deploy** aunque el **build** esté OK (*Deployment failed, try again later*). El sitio puede quedar en la versión anterior.

1. **Automático:** el workflow `Pages recovery` se dispara solo si falla el deploy.
2. **Manual:**
   ```powershell
   .\scripts\rebuild-pages.ps1
   ```
3. O en GitHub: **Actions** → `Pages recovery` → **Run workflow**.

## Remotes en Dev (no tocar a mano)

- `origin` → `C:\Projects\puntonexo-landing` (push de trabajo)
- `github` → fetch de `mellomda3/puntonexo-landing`

El hook `.git/hooks/pre-push` debe estar **desactivado** (`pre-push.disabled`) para permitir push a `C:\Projects` (igual que TPV).
