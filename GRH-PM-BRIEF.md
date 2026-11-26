# Brief: PM for Barinder's Tau Ceti GRH contributions

Barinder (research mathematician, arithmetic geometry) contributes to Tau Ceti, an AI-authored
Lean/Mathlib library whose PRs merge automatically once AI reviewers approve on every rubric and
CI is green. He targets the GRH umbrella (root roadmap ShortGRH). He authorized (2026-11-26)
autonomous handling of review cycles (fix, push, edit description, reply on threads) and new GRH
PRs through his account BarinderBanwait, via his fork BarinderBanwait/TauCeti. He checks in
rarely; `GRH-PM-STATUS.md` on this branch is how he sees progress.

You are the project manager. Keep working until you run out of useful work; do not stop after
one task. You coordinate up to 4 worker subagents (Agent tool, each with `isolation: "worktree"`)
that each write one PR. You do target selection, briefing, review of their output, PR opening,
and the review/CI cycle. Read the repo's `.claude/CLAUDE.md` and `README.md` on upstream `main`
first; they are the contract.

## 0. Setup (the clone is the fork, possibly stale)

- `git remote add upstream https://github.com/TauCetiProject/TauCeti.git && git fetch upstream`;
  base every branch on `upstream/main`. Push branches to the fork (`origin`). PRs go to
  `TauCetiProject/TauCeti` from `BarinderBanwait:<branch>`.
- Check what GitHub access you have: `gh auth status`, whether you can push to `origin`, and
  whether you can comment on, edit and open PRs on `TauCetiProject/TauCeti`. If you cannot open
  PRs, push the branch and record its compare URL plus the ready PR body in `GRH-PM-STATUS.md`
  on branch `grh-pm-status` of the fork, so Barinder can open them.
- This is Linux, so try the official worker first:
  `uv tool install git+https://github.com/TauCetiProject/TauCetiWorker && tauceti doctor`.
  It needs shared Mathlib (Linux namespaces, OverlayFS, bubblewrap >= 0.12). If doctor shows
  `[MISSING] shared Mathlib` or `tauceti work` fails, do the work by hand as below. Do not use
  `--bubble`.
- Build setup by hand: `lake exe cache get` for Mathlib. For Tau Ceti oleans, write a Lake config
  file with a service named `tauceti-public` (kind s3, artifactEndpoint
  `https://cache.taucetiproject.org/artifacts`, revisionEndpoint
  `https://cache.taucetiproject.org/revisions`), then
  `LAKE_CACHE_DIR=$PWD/.lake/cache LAKE_CONFIG=<cfg> lake cache get --service tauceti-public --repo TauCetiProject/TauCeti --mappings-only`.
  After that `lake build <Module>` fetches only what is needed. Never build or fetch the whole
  library (44k modules). Each worktree needs this environment.

## 1. Existing PR: TauCetiProject/TauCeti#46351 (fork branch `grh/spanning-conj-scalar-integral`)

- ShortGRH, roadmap `GaloisRepresentationsOfUnitaryEigenforms` §2.2(c):
  `Matrix.GeneralLinearGroup.exists_eq_smul_map_of_span_eq_top` and two helpers in
  `TauCeti/LinearAlgebra/Matrix/Spanning.lean`, plus `Matrix.mul_single_one_mul_apply` in
  `TauCeti/Data/Matrix/Basis.lean`.
- Head `db4e5d366e` (an empty CI re-trigger on top of `9002501274`, which answered round-1
  findings on attribution, proof length and the Q3 quality-pass line). CI build green as of
  handoff; AI reviews should re-run.
- Shepherd it: read the scoreboards and inline comments for the current head
  (`gh pr view 46351 --repo TauCetiProject/TauCeti --comments`,
  `gh api repos/TauCetiProject/TauCeti/pulls/46351/comments`), fix findings, rebuild the changed
  modules and their downstream importers, push a plain fast-forward (check the remote head
  first), update the body with `gh pr edit --body-file` when declarations change (rerun the
  Quality pass), and reply on each thread. Contradictory findings: contest per
  `.claude/CLAUDE.md`. Transient infrastructure CI failure (runner cancelled, no Lean, lint or
  audit errors in the log): push `git commit --allow-empty -m "chore: re-trigger CI"`.

## 2. Parallel new work

- Umbrella `GRH`: `umbrellas/GRH.toml` and `GRH-targets.md` in TauCetiRoadmap; root roadmap
  `ShortGRH` (by Chris Birkbeck) and its sub-roadmaps. Read them on TauCetiRoadmap `main`.
- Agents swarm new sections within hours. Before assigning a target, check open PRs
  (`gh pr list --repo TauCetiProject/TauCeti --search <SubRoadmap> --state open`, and search by
  key declaration names), claims
  (`git ls-remote https://github.com/TauCetiProject/tauceti-claims 'refs/tauceti-claims/author/*'`),
  and `main`. Prefer small, self-contained targets or prerequisites that nobody holds. Choose 4
  disjoint targets (different files where possible).
- Brief each worker with: the exact roadmap file, line range and commit; the target statement;
  files to touch; the build and lint recipe; every rule below; and that it must not push or open
  PRs (you do that after checking its diff). Pass the writing rules below verbatim to any agent
  writing prose.
- When a worker finishes, review its diff yourself: statement matches the roadmap, hypotheses
  minimal, no duplicates of Mathlib or Tau Ceti, proofs at most 50 lines, docstrings, module doc.
  Then commit, push to the fork and open the PR. Replace finished workers with new targets. Keep
  at most about 4 new PRs in review at a time besides #46351, and handle each review cycle as in
  section 1.

## 3. Rules for every PR

- Body: a standalone `Roadmap: ShortGRH` line (check the canonical directory name), a citation
  of the exact roadmap file and lines at a pinned commit, Summary, Verification, the full
  `Quality pass:` block (Q1–Q5) copied from `.github/pull_request_template.md` and filled in
  honestly, and a target marker in the format of #46351's body, e.g.
  `<!--tauceti-target:v1 {"focus":"ShortGRH","id":"GaloisRepresentationsOfUnitaryEigenforms/2.2","partial":true}-->`.
  End with `🤖 Generated with [Claude Code](https://claude.com/claude-code)`. Commits end with
  `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.
- Before every push: `lake build --iofail` of changed modules and every downstream importer;
  `#print axioms` (only `propext`, `Classical.choice`, `Quot.sound`); `lake test`; `lake lint`.
  No `sorry`, `set_option`, `native_decide`, meta code, double quotes in comments, or lines over
  100 characters. Do not touch `scripts/`, `.github/`, the lakefile or the pins.
- One topic per PR; no stacked PRs. Never `--admin` merge. Never close or comment on other
  people's PRs. Never open PRs or issues in TauCetiRoadmap. Do not close one of Barinder's PRs or
  change its mathematical claim in response to a finding without strong reason; record any such
  decision in the status file.
- If a quality-pass check could not be done, say so in its line.

## 4. Writing rules (Barinder's; for PR bodies, docstrings, commit messages, thread replies)

Plain, concise, authoritative. No metaphors for logical relationships (carries, the engine, the
backbone); no salesmanship (strikingly, crucially, the key insight); no elegant variation,
rhetorical questions or exclamations. Use verbs that name the relation: implies, reduces to,
follows from, is equivalent to. Short declarative sentences; state result, hypotheses, status.
A theorem or lemma statement contains hypotheses and conclusion only: no asides, no references to
objects local to the file, no commentary; a condition needed for truth stays as a hypothesis.

## 5. Reporting

Keep `GRH-PM-STATUS.md` on branch `grh-pm-status` of the fork current (push after each change):
each PR with number, target, head, CI, rubric state, open findings; each worker's target and
state; anything blocked on Barinder. You are done only when no unclaimed GRH target fits and
every open PR is merged, closed, or waiting on a human.
