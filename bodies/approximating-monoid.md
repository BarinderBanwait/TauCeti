Roadmap: ShortGRH

Roadmap target on TauCetiRoadmap `main`: [`TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md` L379–L387](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L379-L387), §2.4: the definition of an approximating monoid and part (a), that a nonzero function in the uniform closure of the span of `S` yields an approximating monoid containing the eigenvalue systems of operators that do not increase the sup norm, and that the approximation passes to polynomials. This PR formalises the definition and both statements of (a). Part (b) needs 2.1 (c) and 2.3 and remains, so the target marker below is partial.

### Summary

New file `TauCeti/Topology/Algebra/UniformConvergence/ApproximatingMonoid.lean`. Write `I = Σ η : Set.Ioi (0 : ℝ), Fin (s η)`; `η → 0` is the filter `atBot` on `Set.Ioi (0 : ℝ)`.

- `UniformFun.exists_forall_dist_le_of_mem_closure`: if `f` lies in the closure of `A` in `X →ᵤ β`, `β` pseudometric, then every `ε > 0` has `g ∈ A` with `dist (f x) (g x) ≤ ε` for all `x`.
- `Submonoid.IsApproximating s c N`, for `N : Submonoid (K × (I → K))`, `K` a uniform semiring: `N` is closed and `∑ i, c η i * φ ⟨η, i⟩` tends to `t` as `η → 0`, uniformly over `(t, φ) ∈ N`.
- `Submonoid.IsApproximating.tendstoUniformly_eval`: over a commutative uniform ring, for `B : MvPolynomial σ K` and a family `f p : σ → N`, `∑ i, c η i * eval (fun x ↦ (f p x).2 ⟨η, i⟩) B` tends to `eval (fun x ↦ (f p x).1) B` uniformly in `p`. By induction on `B`: a monomial evaluated at elements of `N` is a scalar times an element of `N`.
- `Submonoid.exists_isApproximating_of_mem_closure_span`: over a normed field, for `f ≠ 0` in the closure of `span K S` in `X →ᵤ K`, there are `s`, `c`, an approximating `N` and `y : I → X → K` with values in `S` such that `(t, φ) ∈ N` whenever a linear `T` that does not increase the sup norm has `T f = t • f` and `T (y i) = φ i • y i` for all `i`. For each `η` take a combination `∑ j, a η j • y η j` within `η * ‖f z‖` of `f`, where `f z ≠ 0`, and `c η j = a η j * y η j z / f z`; `N` is the closure of the monoid of eigenvalue systems.

The uniform closure is Mathlib's `closure` in `X →ᵤ K`; no new closure is defined. The module docstring credits grh-lean in a Provenance paragraph.

### Verification

- `lake build --iofail TauCeti.Topology.Algebra.UniformConvergence.ApproximatingMonoid` with the repository's `leanOptions`: no warnings. The PR adds one file and changes no existing module, so there are no downstream importers.
- `#print axioms` for the four public declarations: `propext`, `Classical.choice`, `Quot.sound` only.
- Mathlib's `#lint` on the module: all checks pass.
- `lake lint` was not run: in the shallow clone it stops with the message that the local check scope cannot be determined from shallow history. CI runs it.
- No `sorry`, `set_option`, macros or double quotes in comments; every line has at most 100 characters.

Quality pass:
- Q1 Mathlib duplicates: checked — searched `Mathlib/Topology/UniformSpace/UniformConvergenceTopology.lean`, `Mathlib/Topology/Algebra/UniformConvergence.lean` and the metric-space files for a characterisation of the closure in `X →ᵤ β` by uniform `ε`-approximation (none). Reused: `UniformFun.hasBasis_nhds_of_basis`, `mem_closure_iff_nhds_basis`, `Metric.uniformity_basis_dist_le`, `TendstoUniformly.add`, `uniformContinuous_mul_left'`, `le_on_closure`, `Submonoid.topologicalClosure`, `Submodule.mem_span_set'`, `Metric.tendstoUniformly_iff`.
- Q2 Tau Ceti duplicates, on main and in open PRs: checked — searched main and open PRs for approximating monoids, uniform closures and pseudocharacters built from them: none.
- Q3 Hypotheses: declined — `[IsUniformAddGroup K]` and `[UniformContinuousConstSMul K K]` in `tendstoUniformly_eval` are unresolved: the proof uses them for sums and scalar multiples, and I have no counterexample without them. `[NormedField K]` in `exists_isApproximating_of_mem_closure_span` is the roadmap's setting and was not weakened. Kept, with counterexamples: `hf₀` (`S = ∅`, `f = 0`: `I` is empty, so every sum is `0`, while `T = id`, `t = 1` puts `(1, φ)` in `N`); `hf` (`S = ∅`, any `f ≠ 0`, the same argument); the sup-norm condition on `T` (`K = ℝ`, `X = ℕ`, `S = {δ_n}`, `f = ∑ 2^{-n} δ_n`: a linear `T` with `T δ_n = δ_n` and `T f = 2 f` puts `(1, 1)` and `(2, 1)` in `N`, and the same sums cannot tend to both). `IsApproximating` and `tendstoUniformly_eval` assume only uniform semiring and ring structure, and closedness of `N` is not used by `tendstoUniformly_eval`.
- Q4 Section variables: checked — `variable [NormedField K] {X : Type*}` is introduced after `tendstoUniformly_eval` and used by the two declarations that follow.
- Q5 Proofs of at most 50 lines: checked — the longest proof, `exists_isApproximating_of_mem_closure_span`, has 37 lines; the others have at most 9.

<!--tauceti-target:v1 {"focus":"ShortGRH","id":"GaloisRepresentationsOfUnitaryEigenforms/2.4","partial":true}-->

🤖 Generated with [Claude Code](https://claude.com/claude-code)

https://claude.ai/code/session_01HH3uUYkPpqrzJ2jFRJh8H7
