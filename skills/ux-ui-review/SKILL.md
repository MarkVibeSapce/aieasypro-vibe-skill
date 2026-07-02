---
name: ux-ui-review
description: UX/UI review for all user types across every screen and flow.
license: MIT
---

# UX/UI Review

Goal: every user can accomplish their task without confusion. The product looks professional.

Invoke when: user asks to review a project, audit the UI, check usability, or when running alongside code review.

## How to run

**0. Reviewer map** — run once, when the build is otherwise done, before final sign-off. Two
separate lists, don't merge them:
- **In-app roles** — pull straight from `roles.md`/`wireframe.lock.md` if present (every
  `data-role` found). Each is reviewed by *using* the product as that role.
- **Outside reviewers** — who else looks at this project and in what capacity, even though
  they never touch the running app as an end user: course instructor grading the submission,
  classmates giving peer feedback, the actual business owner/client checking it matches their
  brief, a real target customer doing a first-impression test. Infer these from project
  context (course deliverable vs. client project vs. personal tool) — don't invent generic
  ones that don't apply, and ask if the context is unclear.
Output this as a table before the rest of the report: `Reviewer | Capacity | What they check`.

**1. Scan first** — find all page/screen files and list them before reviewing anything. If screenshots or a live URL are provided, use those as primary evidence.

**2. Identify user types** — who uses this system? (end user, admin, guest, etc.) For each: what is their goal? Cross-check against the in-app roles from step 0 — flag any role in `roles.md` with no matching screen found in the scan (a role that got planned but never built).

**3. Review each screen per user type** — ask three questions:
- Can this user complete their goal without getting stuck?
- Does anything look broken, inconsistent, or amateur?
- What is the single most confusing or frustrating moment in their flow?

Apply standard UX/UI judgment: usability, visual hierarchy, accessibility, responsiveness, feedback states, empty states, forms, navigation. Skip criteria that clearly don't apply to this project — state why.

**4. Write the report**

```
## UX/UI Review — [Project Name]

### Reviewer Map
| Reviewer | Capacity | What they check |
|---|---|---|
| [in-app role from roles.md] | uses the product as this role | [their goal/flow] |
| [outside reviewer] | [instructor / client / real customer / peer] | [what they'd judge] |

Screens found: [list]
User types: [list]
Roles in roles.md with no screen found: [list, or "none"]

### [User Type]

#### Top friction point
- [The single worst moment in this user's flow]

#### Critical (blocks task completion)
- [Screen]: [issue] → [fix]

#### Major (degrades experience)
- [Screen]: [issue] → [fix]

#### Minor (polish)
- [Screen]: [issue] → [fix]

#### What's working well
- [keep these — don't remove in next iteration]
```

Severity guide: Critical = user cannot finish their task. Major = user finishes but frustrated. Minor = looks unprofessional but functional.

