# GRH PM status

Updated 2026-11-27 03:05 (UTC) by the PM cloud session. Brief: `GRH-PM-BRIEF.md` on this branch.

## Session

- 2026-11-26 late: a new PM session (source `TauCetiProject/TauCeti`, fork attached as
  `BarinderBanwait/TauCeti-fork` with push access) took over. Barinder confirmed the whole plan
  in that session. It can push to the fork; upstream writes are refused (see below).

## Blocked on Barinder

- Nothing right now. `open-all.sh` was run 2026-11-27 morning: #46351 body updated, seven PRs
  opened (#47165–#47171). Upstream writes from cloud sessions still return 403 (Zulip request
  to Chris pending), so new thread replies and body edits will again be collected here.

## Environment

- Environment `TauCeti` (personal) allows `release.lean-lang.org`, `releases.lean-lang.org`,
   `cache.mathlib.org`, `cache.taucetiproject.org`. `env-setup.sh` on this branch is the setup
   script proposed for it (elan, Mathlib cache, Tau Ceti cache mappings).

## Handoff for a new session

Handed off 2026-11-26 to cloud session "Tau Ceti GRH PM (Barinder)", which has
`TauCetiProject/TauCeti` as its source and attaches the fork, now `BarinderBanwait/TauCeti-fork`.
That session owns #46351 and all new PRs from here; the first session stops after forwarding
the target survey.

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

- 11:10 UTC: merge conflict with main in `TauCeti/Data/Matrix/Basis.lean` (module docstring).
  Resolved by merging `origin/main` (`a9994620`) into the branch, no force-push; Basis and
  Spanning build and lint clean; all 125 downstream modules built green. Pushed merge commit
  `c7ac1070`. The body's Verification still names `3926713b` and 92 modules; minor, update on
  the next body edit.


- Branch `grh/spanning-conj-scalar-integral`. Head before this session `db4e5d36`.
- Round on `db4e5d3`: correctness, reuse, scope, generality, placement, naming, quality-pass
  approved. Open findings: api-design (`@[simp]` on `mul_single_one_mul_apply`), attribution and
  documentation (module doc credited the roadmap), proof-quality (move `[IsDomain L]` to
  `[IsDomain O]`; rewrite chains).
- Fix commit `73bed405`, pushed to the PR branch 2026-11-26: `@[simp]` added; roadmap sentence
  removed; `[IsDomain L]` replaced by `[IsDomain O]` in both scalar-factorization theorems, the
  proof cancelling only the ideal generator `d` in `O`; proof at 50 lines. Verified: build of
  the two modules and all 92 downstream importers (`--iofail`, green); axioms are the standard
  three; Mathlib `#lint` on both modules (15 linters incl. simpNF) passes. `lake lint` could not
  run here (shallow clone: the scope check needs history).
- 23:52 UTC: CI `pr-build / sandboxed-build` on `73bed405` in progress since 23:40; AI review
  waits for it. Last scoreboards (on `db4e5d3`) had api-design, attribution, documentation and
  proof-quality (IsDomain) open; `73bed405` addresses all four.
- 00:17 UTC: CI green on `73bed405` (sandboxed build 23:40–23:53). Reviews on `73bed40`:
  proof-quality approved by the Claude judge; pi-codex proof-quality asked to extract the span
  induction and shorten the cancellation; two quality-pass threads (Claude and pi-codex) say Q3
  still describes `[IsDomain L]`. The body in `PR-46351-body.md` already fixes Q3; it cannot be
  posted from here.
- Pushed `770e03b9` (extract `inv_mul_map_mul_mem_range_of_span_eq_top`; `simpa` entry step;
  `hfd` and a two-step cancellation `calc`) and `73911761` (module docstring lists the new
  lemma). Built `Spanning` and its two downstream importers (the only ones), axioms standard,
  Mathlib `#lint` clean. Body and `open-all.sh` replies updated for this head.
- 01:10 UTC: CI green on `73911761` (build and audits against main `557dcf0f`, bump-guard,
  scope; 00:58). AI review on `73911761` not posted yet.
- 02:05 UTC: round 2 on `7391176` (pi-codex): proof-quality asked that `hfd` use
  `Matrix.of_apply` instead of `rfl`, fixed in `3926713b` (Spanning and both importers build);
  quality-pass again asks for the Q3 update that `PR-46351-body.md` makes. Body heads and the
  `open-all.sh` reply updated. Quality-pass cannot turn green until the body is posted.
- 03:05 UTC: CI on `3926713b` still pending; no review round on it yet. All code findings so
  far are fixed; the open blocker is quality-pass, which needs the body in `PR-46351-body.md`
  posted. The PM stopped scheduled checks here. After `open-all.sh`, reply on any new threads,
  or comment `/review` if a rubric needs a re-run after the body edit.
- New PR body: `PR-46351-body.md` on this branch (Summary, Q3 and Q5 updated).
- Thread replies to post (each ends with the footer
  `---` / `_Generated by [Claude Code](https://claude.ai/code)_`):
  - api-design (both threads): Added `@[simp]` to `mul_single_one_mul_apply` in `73bed405`.
  - attribution and documentation: Removed the sentence crediting the roadmap; the module doc
    now states the ideal-generator argument directly. `73bed405`.
  - proof-quality (IsDomain): Both theorems now take `[IsDomain O]` in place of `[IsDomain L]`;
    the only cancellation is of the generator `d ≠ 0` in `O`. `73bed405`.
  - proof-quality (rewrite chains, `show`): these were on `57e4e7f` and were answered by
    `9002501`; the current proof has no `show` and uses `simp` for entry normalization.

### To open: §4.1 prerequisite, power minors and a small charpoly factor

- **PR #47165.** Fork branch `grh/pow-minor`, head `e9ec5a89` on main `557dcf0f`. One new file,
  `TauCeti/LinearAlgebra/Matrix/Charpoly/PowMinor.lean` (132 lines). Reviewed by the PM.
- Title: `feat: linear dependence of matrix powers via minors, and small factors of the
  characteristic polynomial`
- Body: `bodies/pow-minor.md` on this branch. Open with
  `gh pr create --repo TauCetiProject/TauCeti --base main --head BarinderBanwait:grh/pow-minor
  --title "<title>" --body-file bodies/pow-minor.md`, or via
  https://github.com/TauCetiProject/TauCeti/compare/main...BarinderBanwait:TauCeti-fork:grh/pow-minor?expand=1
- PR creation from this session returned 403 like the other upstream writes.

### To open: §9.1(b) core, stabiliser weights on orbits

- **PR #47166.** Fork branch `grh/stabilizer-weight`, head `a4317e42` on main `557dcf0f`. One new file,
  `TauCeti/GroupTheory/GroupAction/Orbit/StabilizerWeight.lean` (121 lines). Reviewed by the
  PM; the PM added the grh-lean URL and licence to the Provenance paragraph.
- Title: `feat: stabiliser weights on the orbits of a finite group`
- Body: `bodies/stabilizer-weight.md`. `gh pr create --repo TauCetiProject/TauCeti --base main
  --head BarinderBanwait:grh/stabilizer-weight --title "<title>" --body-file
  bodies/stabilizer-weight.md`, or
  https://github.com/TauCetiProject/TauCeti/compare/main...BarinderBanwait:TauCeti-fork:grh/stabilizer-weight?expand=1

### To open: §3.2 prerequisite, free integers

- **PR #47167.** Fork branch `grh/free-integers`, head `4e220b68` on main `557dcf0f`. One new file,
  `TauCeti/Combinatorics/Additive/FreeIntegers.lean` (204 lines). Reviewed by the PM.
- Title: `feat: free families of integers and lacunary sufficient conditions`
- Body: `bodies/free-integers.md`. `gh pr create --repo TauCetiProject/TauCeti --base main
  --head BarinderBanwait:grh/free-integers --title "<title>" --body-file
  bodies/free-integers.md`, or
  https://github.com/TauCetiProject/TauCeti/compare/main...BarinderBanwait:TauCeti-fork:grh/free-integers?expand=1

### To open: §5.6(d), root quotients

- **PR #47168.** Fork branch `grh/root-quotient`, head `22600a1b` on main `557dcf0f`. One new file,
  `TauCeti/Algebra/Star/RootQuotient.lean` (202 lines), stated for star algebras. Reviewed by
  the PM; the PM added the grh-lean URL and licence to the Provenance paragraph.
- Title: `feat: root quotients of polynomials at elements of a star algebra`
- Body: `bodies/root-quotient.md`. `gh pr create --repo TauCetiProject/TauCeti --base main
  --head BarinderBanwait:grh/root-quotient --title "<title>" --body-file
  bodies/root-quotient.md`, or
  https://github.com/TauCetiProject/TauCeti/compare/main...BarinderBanwait:TauCeti-fork:grh/root-quotient?expand=1

### To open: §2.1(d), twists of semisimple representations

- **PR #47169.** Fork branch `grh/twist-semisimple`, head `48d3af6f` on main `557dcf0f`. One new file,
  `TauCeti/RepresentationTheory/Character/Twist/Semisimple.lean` (85 lines). Reviewed by the PM.
- Title: `feat: twists of semisimple representations by linear characters are semisimple`
- Body: `bodies/twist-semisimple.md`. `gh pr create --repo TauCetiProject/TauCeti --base main
  --head BarinderBanwait:grh/twist-semisimple --title "<title>" --body-file
  bodies/twist-semisimple.md`, or
  https://github.com/TauCetiProject/TauCeti/compare/main...BarinderBanwait:TauCeti-fork:grh/twist-semisimple?expand=1

### To open: §2.4(a), approximating monoids

- **PR #47170.** Fork branch `grh/approximating-monoid`, head `dbb674eb` on main `557dcf0f`. One new file,
  `TauCeti/Topology/Algebra/UniformConvergence/ApproximatingMonoid.lean` (167 lines). Reviewed
  by the PM; the PM added the grh-lean URL and licence to the Provenance paragraph.
- Title: `feat: approximating monoids from uniform closures`
- Body: `bodies/approximating-monoid.md`. `gh pr create --repo TauCetiProject/TauCeti --base
  main --head BarinderBanwait:grh/approximating-monoid --title "<title>" --body-file
  bodies/approximating-monoid.md`, or
  https://github.com/TauCetiProject/TauCeti/compare/main...BarinderBanwait:TauCeti-fork:grh/approximating-monoid?expand=1

### To open: §2.1(e), cancelling disjoint families of characters

- **PR #47171.** Fork branch `grh/character-cancellation`, head `19a3131c` on main `557dcf0f`. One new file,
  `TauCeti/RepresentationTheory/Semisimple/CharacterCancellation.lean` (220 lines). Reviewed by
  the PM; the PM added the grh-lean URL and licence. Likely review point: placement of the two
  general lemmas `char_pi` and `exists_fdRep_isSemisimpleRepresentation_character_eq`.
- Title: `feat: cancel two disjoint families of characters from semisimple representations`
- Body: `bodies/character-cancellation.md`. `gh pr create --repo TauCetiProject/TauCeti --base
  main --head BarinderBanwait:grh/character-cancellation --title "<title>" --body-file
  bodies/character-cancellation.md`, or
  https://github.com/TauCetiProject/TauCeti/compare/main...BarinderBanwait:TauCeti-fork:grh/character-cancellation?expand=1

Note: #46351, `grh/character-cancellation` and `grh/twist-semisimple` all touch §2.1/§2.2 but
different files; none depends on another, so opening them together is not stacking.

## Workers

Survey: `GRH-target-survey.md`. Picks 1–4 rechecked 2026-11-26 23:40 UTC against open PRs
(search by names and topics), tauceti-claims (`author/ShortGRH/*`) and main `557dcf0f`: free.
Four workers started about 23:42 UTC on main `557dcf0f`, roadmap `9897854`. Their branches go to the
fork; since upstream writes are refused, each gets a compare URL and a ready PR body here.

All workers finished by 00:00 UTC. No new workers: seven branches await opening, above the
brief's limit of about four PRs in review.

| Worker | Target | State |
|---|---|---|
| 1 | §3.2 prerequisite: free integers; lacunary and rapidly decreasing sequences are free | done, branch pushed (see PRs) |
| 2 | §4.1 prerequisite: power minors; small factor of the charpoly | done, branch pushed (see PRs) |
| 5 | §2.4(a): approximating monoids from uniform closures | done, branch pushed (see PRs) |
| 6 | §2.1(e): cancelling two disjoint families of characters | done, branch pushed (see PRs) |
| 7 | §2.1(d): twist of a semisimple representation is semisimple (survey backup) | done, branch pushed (see PRs) |
| 3 | §5.6(d): root quotients at a unitary matrix | done, branch pushed (see PRs) |
| 4 | §9.1(b) core: orbit weights summing to `c` | done, branch pushed (see PRs) |
