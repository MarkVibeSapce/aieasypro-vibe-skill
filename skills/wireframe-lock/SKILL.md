---
name: wireframe-lock
description: >-
  การันตี wireframe → ระบบจริง "ตรง 100%". แก้ปัญหา build ออกมาไม่ตรง wireframe.
  ทำงาน 3 เฟส: design (สร้าง wireframe.html แบบมีกฎ = สัญญา) → lock (freeze สเปค) →
  build+verify (port 1:1 + เทียบทีละจุด). ใช้ตั้งแต่ออกแบบ wireframe ก่อน build.
  Trigger: "ทำ wireframe", "/wireframe-lock", "wireframe ไม่ตรง", "build ตาม wireframe",
  "ออกแบบหน้าเว็บก่อน build", "lock design", "port wireframe เป็น code".
---

# wireframe-lock — wireframe = สัญญา, build = port, แล้ว verify

**ปัญหาที่แก้:** สั่ง Claude "build ตาม wireframe" แล้วออกมาไม่ตรง — เพราะ Claude
"วาดใหม่" ไม่ใช่ "แปลง", และ wireframe เป็นแค่รูปที่ไม่บอก component/data/state/copy.

**หลักการ:** ทำ wireframe ให้เป็น **สัญญาที่อ่านได้ทั้งคนและ AI** → build กลายเป็นการ
**port เชิงกล (1:1)** ไม่ใช่การตีความ → แล้ว **critique เทียบ wireframe** จนตรง.

> กฎทอง: ยิ่ง wireframe เขียนด้วย tech เดียวกับ build (Tailwind) + มี annotation ครบ
> → build ยิ่งเป็นแค่ "ย้าย markup เข้า .tsx" → drift เกือบ 0.

---

## 🅰️ เฟส 1 — DESIGN: สร้าง wireframe.html แบบมีกฎ

ใช้ `wireframe.template.html` ในโฟลเดอร์นี้เป็นจุดเริ่ม. wireframe **ต้องมี 3 อย่าง**:

### 1. Token block (บนสุดของไฟล์) — สัญญาเรื่องหน้าตา
ปรับจากหลัก frontend-design: กำหนด token *ก่อน* วาด แล้ว build สืบทอดค่าเดียวกัน
```html
<!-- DESIGN TOKENS — build ต้องใช้ค่านี้เป๊ะ ห้ามเปลี่ยน
  color:   primary #2F80ED / ink #0B1F3A / bg #FFFFFF / muted #6B7280 / accent #F2C94C
  font:    display "Poppins" / body "Sarabun"
  spacing: หน่วยฐาน 4px (Tailwind default) — section gap = py-16
  radius:  rounded-xl (การ์ด) / rounded-lg (ปุ่ม)
  signature: [1 อย่างที่จำได้ของหน้านี้ เช่น การ์ดวิลล่ามีป้ายราคาลอยมุมขวาบน]
-->
```

### 2. Annotation — ปิดช่องที่ AI เดา
ฝัง `data-*` ในทุก element สำคัญ:

| annotation | ความหมาย | ตัวอย่าง |
|-----------|----------|----------|
| `data-screen="/path"` | หน้านี้ = route ไหน | `data-screen="/villas"` |
| `data-component="Name"` | ขอบเขต component (→ 1 React component ชื่อเดิม) | `data-component="VillaCard"` |
| `data-field="table.col"` | ค่านี้มาจาก database.md ไหน | `data-field="villa.name"` |
| `data-state="empty\|loading\|error"` | บล็อกนี้คือ state ไหน | `data-state="empty"` |
| `data-action="ชื่อ"` | ปุ่ม/ลิงก์ทำอะไร ไปไหน | `data-action="goto:/villa/:id"` |

### 3. Copy จริง (ไม่ใช่ lorem) — copy คือ design material
ปรับจาก frontend-design:
- เขียน copy ไทยจริงที่จะใช้ — ห้าม "ข้อความตัวอย่าง..." เพราะ copy ที่ลอย = build เดา
- **active voice + ชื่อ action คงที่ทั้ง flow** — ปุ่ม "จองเลย" → toast "จองสำเร็จ" (คำเดียวกัน)
- **empty/error = ทิศทาง ไม่ใช่อารมณ์** — "ยังไม่มีวิลล่าในพื้นที่นี้ ลองเปลี่ยนอำเภอ" ไม่ใช่ "ไม่พบข้อมูล :("
- ตั้งชื่อสิ่งของด้วยภาษาที่ user รู้จัก ไม่ใช่ภาษาระบบ ("การแจ้งเตือน" ไม่ใช่ "webhook config")

**Restraint (Chanel rule):** signature เด่นได้ 1 อย่าง ที่เหลือเงียบ. ตรงกับ MVP ceiling
ของคอร์ส — ≤3 หน้า. ตัด decoration ที่ไม่รับใช้ทั้งหมด. **ไม่ต้องหวือหวา ขอแค่ตรง.**

---

## 🅱️ เฟส 2 — LOCK: freeze สเปค

เมื่อ wireframe นิ่งแล้ว สั่ง Claude:
```
/add-file wireframe.html
/add-file docs/database.md
อ่าน wireframe.html แล้วสร้าง wireframe.lock.md — list ออกมาตาม annotation:
- ทุก screen (route)
- ทุก component (ชื่อ + อยู่หน้าไหน + data-field ที่ใช้)
- ทุก state (empty/loading/error) ของแต่ละ component
- ทุก action (ปุ่มไปไหน)
อย่าเพิ่มอะไรที่ไม่มีใน wireframe. ถ้ามีช่องโหว่/ขัดกัน — ถามก่อน ห้ามเดา
```
→ อ่าน `wireframe.lock.md` → ยืนยัน → **นี่คือสัญญาตายตัว. build ต้องตรงกับไฟล์นี้.**

หา gap ตรงนี้ถูกกว่าหาตอน build: component ซ้ำชื่อ, field ไม่มีใน database, state ขาด,
ปุ่มไปหน้าที่ยังไม่มี → แก้ที่ wireframe ก่อน lock ใหม่.

---

## 🅲️ เฟส 3 — BUILD (port 1:1) + VERIFY (critique)

### Build — สั่งเป็น "port" ไม่ใช่ "สร้าง"
```
/add-file wireframe.html
/add-file wireframe.lock.md
/add-file docs/design.md

Port wireframe.html เป็น Next.js pages — 1:1
กฎ:
- รักษาโครง DOM, ลำดับ element, class Tailwind, และ copy ให้ตรงเป๊ะ
- แต่ละ data-component = 1 React component ไฟล์เดียว ชื่อเดิม
- แต่ละ data-screen = 1 route ใน app/
- ใช้ design token จาก wireframe เท่านั้น ห้ามคิดสี/ฟอนต์/spacing ใหม่
- data-field ผูกกับ table ตาม database.md (ยังไม่ต่อ DB จริง ใช้ mock ตาม lock)
- สร้าง state ครบทุก data-state ที่ระบุ
ห้าม redesign ห้ามเพิ่มหน้า/ปุ่ม/section ที่ไม่มีใน lock
```

### Verify — critique เทียบทีละจุด (two-pass ตาม frontend-design)
เปิด `wireframe.html` กับ `localhost:3000` วางข้างกัน. ไล่ checklist ต่อหน้า:

**ตรงโครง (fidelity)**
- [ ] component ครบตาม lock — ไม่ขาด ไม่เกิน
- [ ] ลำดับ + layout ตรง (อะไรอยู่บน/ล่าง/ซ้าย/ขวา)
- [ ] copy ตรงคำต่อคำ
- [ ] สี/ฟอนต์/ระยะ = token เป๊ะ
- [ ] ทุกปุ่มไปหน้าถูกตาม data-action
- [ ] state ครบ (ลองทำให้ empty/error โผล่)

**Quality floor (ตาม frontend-design — ปิดท้ายทุกหน้า)**
- [ ] responsive ลง mobile ไม่พัง (DevTools Ctrl+Shift+M)
- [ ] keyboard focus เห็น (กด Tab)
- [ ] empty/error เป็นข้อความบอกทางออก ไม่ใช่หน้าเปล่า

เจอไม่ตรง → บอก Claude ชี้จุด: "หน้า X component Y ไม่ตรง: [ต่างยังไง] — แก้ให้ตรง lock".
วน build→verify จนผ่านทุกช่อง **ก่อนไปหน้าถัดไป** (กัน context หลุด/drift สะสม).

---

## เชื่อมกับ skill อื่น
- ก่อนหน้า: `md-scaffold` (ได้ design.md + database.md ที่ annotation อ้างถึง)
- หลัง: `build-frontend` (เฟส 3 คือ build-frontend เวอร์ชันคุม fidelity), `ux-ui-review`
- token/copy discipline ปรับจาก skill `frontend-design` ของ Anthropic

## สรุป flow
```
DESIGN wireframe.html (token+annotation+copy) → LOCK wireframe.lock.md (freeze)
   → BUILD port 1:1 → VERIFY checklist → ตรง → หน้าถัดไป
```
