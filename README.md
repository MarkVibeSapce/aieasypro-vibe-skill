# AI Easy Pro — Vibe Coding Skills

ชุด **skills** สำหรับ Claude Code ที่ใช้ในคอร์ส Vibe Coding Bootcamp
ช่วยให้ build MVP เร็วขึ้น ทำงานเป็นระบบตั้งแต่วันแรก

ติดตั้งครั้งเดียว → ใช้ได้ทุกโปรเจค (ติดตั้งที่ `~/.claude/skills/`)

---

## ⚡ ติดตั้ง (เลือกตามเครื่อง)

> เปลี่ยน `<GITHUB_URL>` เป็น URL repo จริงหลัง push

### 🍎 Mac / Linux

```bash
git clone <GITHUB_URL> aieasypro-vibe-skill
cd aieasypro-vibe-skill
bash install.sh
```

### 🪟 Windows (PowerShell)

```powershell
git clone <GITHUB_URL> aieasypro-vibe-skill
cd aieasypro-vibe-skill
powershell -ExecutionPolicy Bypass -File install.ps1
```

เสร็จแล้ว **เปิด Claude Code ใหม่** → พิมพ์ `/help` → เห็น skills ทั้งหมด

> อัปเดตภายหลัง: `git pull` แล้วรัน install ซ้ำ

---

## 📦 Skills ในชุดนี้

### 🔧 คุณภาพ + Workflow
| Skill | ใช้ทำอะไร |
|-------|-----------|
| `karpathy-guidelines` | กัน AI เขียน code เกินจำเป็น / มั่ว — คิดก่อนโค้ด, แก้เท่าที่จำเป็น |
| `handoff` | เขียนเอกสารส่งต่องาน ให้ chat ใหม่ทำต่อได้ ไม่ต้องเล่าซ้ำ |
| `multimodel` | ให้โมเดลที่เหมาะกับงานแต่ละชิ้น — คุณภาพสูงในราคาเหมาะ |
| `ux-ui-review` | ตรวจ UI/UX ทุกหน้าทุก flow ก่อนส่งงาน |

### 🚀 Build คอร์ส (Day 1–3)
| Skill | ใช้ตอน |
|-------|--------|
| `md-scaffold` | Day 1 — เล่าโปรเจคปากเปล่า → สร้างไฟล์ MD spec ครบชุด |
| `build-frontend` | Day 2 — build Next.js UI ทีละหน้า ตาม MD |
| `supabase-setup` | Day 3 — เชื่อม database + login (AI ออกแบบ schema) |
| `vercel-deploy` | Day 2–3 — deploy ด้วย Vercel CLI ได้ URL จริง ไม่ต้องใช้ GitHub |

---

## 🎯 วิธีใช้ในคอร์ส

1. **Day 1** — เล่าโปรเจค → `/md-scaffold` สร้าง `docs/*.md`
2. **Day 2** — เปิด chat ใหม่ → `/build-frontend` → `/vercel-deploy` (preview)
3. **Day 3** — `/supabase-setup` → `/ux-ui-review` → `/vercel-deploy prod`

ระหว่างทางใช้ `/handoff` เมื่อ context จะเต็ม เพื่อไม่ต้องเล่างานซ้ำ

---

_AI Easy Pro — Vibe Coding Bootcamp_
