# GRH PM status

Updated 2026-11-26 (UTC) by the PM cloud session. Brief: `GRH-PM-BRIEF.md` on this branch.

## Session

- 2026-11-26 late: a new PM session (source `TauCetiProject/TauCeti`, fork attached as
  `BarinderBanwait/TauCeti-fork` with push access) took over. Barinder confirmed the whole plan
  in that session. It can push to the fork, open PRs upstream, edit bodies and reply on threads.

## Blocked on Barinder

- Nothing.

## Environment

- Environment `TauCeti` (personal) allows `release.lean-lang.org`, `releases.lean-lang.org`,
   `cache.mathlib.org`, `cache.taucetiproject.org`. `env-setup.sh` on this branch is the setup
   script proposed for it (elan, Mathlib cache, Tau Ceti cache mappings).

## Handoff for a new session

- Build recipe: install elan; `lake exe cache get`; write the `tauceti-public` Lake config (see
  `env-setup.sh`); `LAKE_CACHE_DIR=$PWD/.lake/cache LAKE_CONFIG=<cfg> lake cache get --service
  tauceti-public --repo TauCetiProject/TauCeti --mappings-only`; then
  `LAKE_CONFIG=<cfg> LAKE_CACHE_DIR=$PWD/.lake/cache lake build --iofail <Module>` fetches the
  rest. A module build takes seconds; 92 downstream modules took about 40 minutes on 4 cores.
- PR conversation pages can be read with a web-fetch agent on
  `https://github.com/TauCetiProject/TauCeti/pull/<n>`; PR search works with
  `gh api -X GET search/issues -f q='repo:TauCetiProject/TauCeti is:pr ...'`.

## PRs

### #46351 — §2.2(c), scalar times integral matrix

- Branch `grh/spanning-conj-scalar-integral`. Head before this session `db4e5d36`.
- Round on `db4e5d3`: correctness, reuse, scope, generality, placement, naming, quality-pass
  approved. Open findings: api-design (`@[simp]` on `mul_single_one_mul_apply`), attribution and
  documentation (module doc credited the roadmap), proof-quality (move `[IsDomain L]` to
  `[IsDomain O]`; rewrite chains).
- Fix commit `73bed405` (backup on fork branch `pm-wip/spanning-conj-scalar-integral`):
  `@[simp]` added; roadmap sentence removed; `[IsDomain L]` replaced by `[IsDomain O]` in both
  scalar-factorization theorems, the proof cancelling only the ideal generator `d` in `O`; proof
  at 50 lines. Module builds; axioms are the standard three. Downstream build of 92 modules
  running; pushed to the PR branch only after it passes.
- New PR body: `PR-46351-body.md` on this branch (Summary, Q3 and Q5 updated).
- Thread replies to post:
  - api-design (both threads): Added `@[simp]` to `mul_single_one_mul_apply` in `73bed405`.
  - attribution and documentation: Removed the sentence crediting the roadmap; the module doc
    now states the ideal-generator argument directly. `73bed405`.
  - proof-quality (IsDomain): Both theorems now take `[IsDomain O]` in place of `[IsDomain L]`;
    the only cancellation is of the generator `d ≠ 0` in `O`. `73bed405`.
  - proof-quality (rewrite chains, `show`): these were on `57e4e7f` and were answered by
    `9002501`; the current proof has no `show` and uses `simp` for entry normalization.

## Workers

- Target survey of `GaloisRepresentationsOfUnitaryEigenforms` running (unclaimed sections not
  on main or in open PRs). ShortGRH has about 144 open PRs, so most sections are taken.
