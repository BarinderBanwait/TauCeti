Roadmap: ShortGRH

Roadmap target on TauCetiRoadmap `main`: [`TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md` L1410–L1437](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L1410-L1437), §9.1 **Taylor–Wiles places, the integral Hecke algebra and Higman operators**, part (b) ([L1436–L1437](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L1436-L1437)): an operator `Ψ` with `Σ_{g∈Δ} g⁻¹Ψg = c`. The method ([L1417–L1419](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L1417-L1419)) obtains `Ψ` from a weight on the orbits of `Δ` equal to `c` divided by the order of a stabiliser. This PR proves that combinatorial step for an arbitrary action of a finite group. The forms of principal level, the integral lattice and the reduction of `|U(n)(E) ∩ gK₀g⁻¹| ∣ c` to stabiliser orders are not formalised here, so the target marker below is partial.

### Summary

New file `TauCeti/GroupTheory/GroupAction/Orbit/StabilizerWeight.lean`, namespace `TauCeti.MulAction`, for `[Group G] [Fintype G] [MulAction G X]`. No finiteness of `X` is assumed.

- `card_filter_smul_eq`: `#{g : G | g • x = a • x} = Nat.card (stabilizer G x)`.
- `sum_smul_eq_natCard_stabilizer_nsmul`: `∑ g : G, f (g • x)` is `Nat.card (stabilizer G x)` times the sum of `f` over the orbit of `x`, for `f` with values in an additive commutative monoid.
- `exists_sum_smul_eq_of_natCard_stabilizer_dvd`: if every stabiliser order divides `c`, some `u : X → ℕ` has `∑ g : G, u (g • x) = c` for every `x`. The weight is `c / |Stab(r)|` at a chosen point `r` of each orbit and `0` elsewhere.
- `exists_sum_smul_eq_iff`: such a weight exists if and only if every stabiliser order divides `c`; the converse follows from `sum_smul_eq_natCard_stabilizer_nsmul`.
- `exists_sum_funLeft_comp_eq_smul`: under the same hypothesis, multiplication by some `u` is an `R`-linear operator `Ψ` on `X → M` with `∑ g : G, funLeft (g • ·) ∘ₗ Ψ ∘ₗ funLeft (g⁻¹ • ·) = c • id`, that is `∑_g g⁻¹Ψg = c` for the action `f ↦ f (g⁻¹ • ·)`.

The module docstring credits grh-lean `New.Patching.exists_orbit_weight` in a Provenance paragraph; the statement here is for an arbitrary action.

### Verification

- `lake build --iofail TauCeti.GroupTheory.GroupAction.Orbit.StabilizerWeight` with the repository's `leanOptions`: no warnings. The PR adds one file and changes no existing module, so there are no downstream importers.
- `#print axioms` for the five declarations: `propext`, `Classical.choice`, `Quot.sound` only.
- Mathlib's `#lint` on the module: all checks pass.
- `lake lint` was not run: in the shallow clone it stops with the message that the local check scope cannot be determined from shallow history. CI runs it.
- No `sorry`, `set_option`, macros or double quotes in comments; every line has at most 100 characters.

Quality pass:
- Q1 Mathlib duplicates: checked — searched Mathlib for sums `∑ g, f (g • x)`, for the cardinality of `{g | g • x = a • x}` and for orbit–stabiliser sum identities; the nearest is `MulAction.card_orbit_mul_card_stabilizer_eq_card_group`, a statement about cardinalities only.
- Q2 Tau Ceti duplicates, on main and in open PRs: checked — `TauCeti/GroupTheory/GroupAction/Orbit/Weight.lean` (`Subgroup.orbitWeight`, a count of cosets) and `Orbit/ENNReal.lean` (`tsum_eq_tsum_natCard_orbit_mul`) are different statements; `TauCeti.card_stabilizer_of_orbitRel` is reused. Searched open PRs for orbit weights, stabiliser weights and Higman operators: none has these statements.
- Q3 Hypotheses: checked — kept: `hc` (necessary by `exists_sum_smul_eq_iff`; for `G = ℤ/2` acting trivially on a point and `c = 1`, `∑_g u (g • x) = 2 u x ≠ 1`); `[Fintype G]` (needed to state the sums over `G`). The decidability argument of `card_filter_smul_eq` is a `DecidablePred` binder so that the lemma rewrites under any instance; `[DecidableEq X]` in `sum_smul_eq_natCard_stabilizer_nsmul` is needed to state `Finset.image`. `R` and `M` are any semiring and any additive commutative monoid module over it.
- Q4 Section variables: checked — the only `variable` line is `{G X : Type*} [Group G] [Fintype G] [MulAction G X]`, used by every declaration.
- Q5 Proofs of at most 50 lines: checked — the longest proof, `exists_sum_smul_eq_of_natCard_stabilizer_dvd`, has 20 lines; the others have at most 6.

<!--tauceti-target:v1 {"focus":"ShortGRH","id":"GaloisRepresentationsOfUnitaryEigenforms/9.1","partial":true}-->

🤖 Generated with [Claude Code](https://claude.com/claude-code)

https://claude.ai/code/session_01HH3uUYkPpqrzJ2jFRJh8H7
