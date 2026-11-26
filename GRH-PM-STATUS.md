# GRH PM status

Updated 2026-11-26 (UTC) by the PM cloud session. Brief: `GRH-PM-BRIEF.md` on this branch.

## Blocked on Barinder

1. **This session cannot act on `TauCetiProject/TauCeti` through GitHub.** Attaching it with
   push access was refused, so the session can read it (git fetch, public search) but cannot
   open PRs, edit PR bodies, or reply on review threads there. It can push to the fork
   `BarinderBanwait/TauCeti`, which updates #46351's head. So:
   - #46351 fixes are pushed to its branch; the new PR body and the thread replies are below,
     ready to paste.
   - New PRs are pushed as fork branches; each has a compare link and a ready body below.
   To lift this, allow the session to attach `TauCetiProject/TauCeti` with push access (or open
   a new session with that repository attached and the GitHub app authorized for it).
2. A personal cloud environment `TauCeti` was created for this work. It allows only
   `release.lean-lang.org`, `releases.lean-lang.org`, `cache.mathlib.org` and
   `cache.taucetiproject.org` (Lean toolchain and the two build caches).

## PRs

### #46351 — §2.2(c), scalar times integral matrix

- Branch `grh/spanning-conj-scalar-integral`. Head before this session `db4e5d36`.
- State: open, `awaiting-author`. Round on `db4e5d3`: correctness, reuse, scope, generality,
  placement, naming, quality-pass approved; open findings: api-design (`@[simp]` on
  `mul_single_one_mul_apply`), attribution and documentation (module doc credited the
  roadmap), proof-quality (move `[IsDomain L]` to `[IsDomain O]`; rewrite chains).
- In progress: fixes for all four, building downstream modules.

## Workers

- Target survey of `GaloisRepresentationsOfUnitaryEigenforms` running (unclaimed sections not
  on main or in open PRs). ShortGRH has about 144 open PRs, so most sections are taken.
