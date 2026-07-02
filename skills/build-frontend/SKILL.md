---
name: build-frontend
description: >-
  ใส่ behavior/logic ทับหน้าที่ port มาจาก wireframe-lock เฟส 3 แล้ว — ทีละหน้า ตาม
  Screens List ใน wireframe.lock.md. คุมให้ตรง lock, review diff ก่อน accept, จับสัญญาณ
  context หมด. ใช้ตอน M6 **หลัง** wireframe-lock ผ่านเฟส LOCK+BUILD แล้วเท่านั้น.
  ไม่ใช่จุดเริ่ม build UI จาก design.md ตรงๆ. Trigger: "build frontend", "สร้างหน้าเว็บ",
  "/build-frontend", "เริ่ม build", "setup next.js", "ใส่ behavior ให้หน้าที่ port แล้ว".
---

# build-frontend — ใส่ behavior/logic ด้วย Claude Code

เป้าหมาย: หน้า UI ที่ `wireframe-lock` เฟส 3 port มาแล้ว (โครง+copy+state ตรง wireframe) —
สกิลนี้ทำให้ **ทำงานจริง** (validation, คำนวณ, submit) ตาม `wireframe.lock.md` +
`features.md`. ทีละหน้า, review ทุก edit. **ไม่ redesign, ไม่สร้าง layout ใหม่.**

## 0️⃣ ENTRY (ห้ามข้าม) — เช็คก่อนเริ่ม

สกิลนี้ไม่ใช่จุดเริ่ม build frontend — ต้องมี wireframe ที่ lock+port มาแล้วก่อนเสมอ.

| เช็ค | ผล |
|---|---|
| มี `wireframe.lock.md` และหน้าที่ port แล้วจาก `/wireframe-lock` เฟส 3 (BUILD)? | ✅ ทำต่อด้านล่าง |
| มีแค่ `design.md`/`features.md` เฉยๆ ยังไม่เคยทำ wireframe | ⛔ หยุด. บอก user: "ต้องทำ wireframe ก่อน" แล้วสั่ง `/wireframe-lock` |

> เหตุผล: build ตรงจาก design.md = AI เดา layout เอง → ไม่ตรงของที่ user เห็น/อนุมัติมาก่อน.
> wireframe-lock เฟส 3 setup Next.js + port UI ให้แล้ว 1:1 (โครง/copy/state).
> สกิลนี้ทำแค่ **เติม logic ทับของที่ port มา** — ไม่ใช่สร้างหน้าใหม่.

## Starter Prompt (prompt แรกของ build)

```
/add-file docs/project.md
/add-file docs/features.md
/add-file docs/database.md
/add-file wireframe.lock.md

อ่าน wireframe.lock.md แล้วใส่ behavior ให้ทุก data-action ในหน้า [X] ทำงานจริง
(validation, คำนวณ, submit) ตาม features.md — ใช้ mock data ก่อน ห้ามแก้ layout/copy/
component ที่ port มาแล้วจาก wireframe
```

## ลำดับ build (บน UI ที่ port มาจาก wireframe-lock แล้ว)

1. **เช็ค ENTRY gate** — มี `wireframe.lock.md` + หน้า ported แล้วหรือยัง (ด้านบน).
2. **ใส่ behavior ทีละหน้า** — ตาม Screens List ใน `wireframe.lock.md`, ทำ `data-action`
   ให้ทำงานจริง (mock data ก่อน).
3. **Navigation** — เชื่อม page-to-page ตาม `data-action="goto:..."`.
4. อย่าเพิ่ง auth/database จริง — นั่น M7 (`supabase-setup`). หน้านี้ทำ logic + mock data ก่อนพอ.

## กฎเหล็ก

- **Review diff ก่อน accept ทุกครั้ง** — กด `d` ดู diff → เข้าใจ → ค่อย `y`. Claude ผิดได้เสมอ.
- **Error → โยนตรงๆ** — copy error ทั้งก้อน ใส่ prompt: `got this error: [paste]` → ให้ Claude
  วิเคราะห์ + แก้เอง. ห้าม user แก้ code เอง.
- **ทีละหน้า** — ใส่ behavior หน้าเดียวให้เสร็จ + ดูใน browser ก่อนไปหน้าถัดไป. อย่าสั่งรวดเดียวทั้งแอป.
- **ตรง wireframe.lock.md** — ถ้า Claude แก้ layout/component/copy นอก lock ให้ทัก:
  "ทำตาม wireframe.lock.md หน้า [X] ห้ามแก้โครง".

## ดู app บน local

- บอก Claude: **"รัน local server ให้หน่อย"** → Claude รัน → เปิด browser ที่ `localhost:3000`.
- localhost = เว็บที่รันบนเครื่องตัวเอง ยังไม่ขึ้น internet — เห็นคนเดียว ใช้ทดสอบก่อน deploy.
- **Iteration loop**: ดูใน local → บอกปัญหาเป็นคำพูด → Claude แก้ → refresh → ดูใหม่.

## Context หมด — สัญญาณ + วิธีแก้

สัญญาณ: Claude ตอบนอกเรื่อง / ลืมว่าทำโปรเจคอะไร / ทำซ้ำสิ่งที่ทำไปแล้ว.

แก้: พิมพ์ `/clear` (หรือเปิด chat ใหม่) → `/add-file` MD files ใหม่ → build ต่อ.
ไม่ต้องอธิบายซ้ำ เพราะ context อยู่ใน MD.

## จบ M6

- Frontend หลักพร้อม + ทดสอบใน browser.
- รัน `vercel` ครั้งแรก → ได้ **preview URL** (ดู skill `vercel-deploy`).
- จด prompts ที่ work + patterns ลง `skill.md`.
