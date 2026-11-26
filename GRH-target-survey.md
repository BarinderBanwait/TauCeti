# Target survey: GaloisRepresentationsOfUnitaryEigenforms

Survey of free targets, 2026-11-26, against TauCetiRoadmap `e314ba4`, upstream main `2a9233e5`,
open PRs (search API) and tauceti-claims. Line numbers refer to
`TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md` at `e314ba4`.
Recheck open PRs and claims before assigning; this area is busy.

## Status by section

| § | Status |
|---|---|
| 1.1 | Partly on main (`TauCeti.glnHeckePolynomial`, NumberTheory/HeckeRing/GLn/HeckePolynomial/Basic.lean); rest needs G_f(n) |
| 1.2–1.6 | Free, blocked (places of Ω, crystalline representations) |
| 2.1(a) | Main: `Representation.isSemisimpleRepresentation_comp_subtype` |
| 2.1(b) | Main: `nonempty_equiv_of_character_eq_of_isSemisimpleRepresentation`; related open #46673 |
| 2.1(c) | Open #46059 |
| 2.1(d) | Free, tiny (backup) |
| 2.1(e) | Free: pick 6 |
| 2.2(a) | Partly on main (`Representation.exists_stable_lattice`); coefficient descent free |
| 2.2(b) | Main (RepresentationTheory/Irreducible/Spanning.lean) |
| 2.2(c) | Open #46351 (ours) |
| 2.2(d) | Spanning half on main; the clause that `u(φ^{-n})` is scalar is free and tiny |
| 2.3 | Free but large; Newton identities already on main |
| 2.4(a) | Free: pick 5 |
| 2.4(b) | Free, needs 2.3 |
| 3.1 | Main (#46166) |
| 3.2 | Main theorem heavy; free-integer lemmas free: pick 1 |
| 3.3 | Blocked |
| 4.1 | Main theorem needs 1.2; minors and charpoly factor prerequisite free: pick 2 |
| 4.2, 4.4, 4.5 | Blocked |
| 4.3(a) | Free; open #46419 is a prerequisite step |
| 5.1 | Partly on main (`MonoidHom.twistedNorm`, `TauCeti.TameHilbert90.IsTameAtLevel`) |
| 5.2 | Main for (a)–(d) (#46171); profinite clauses free, medium–large |
| 5.3–5.5, 5.7–5.9, 5.11 | Blocked |
| 5.6(a)–(c) | Blocked (no star structure on finite adeles) |
| 5.6(d) | Free: pick 3 |
| 5.10 | Free; related open #46658 |
| 6–8 | Blocked |
| 9.1(b) | Combinatorial core free: pick 4 |
| 9.2, 9.3 | Free; need cocycle-module definitions |

## Picks (disjoint files, Mathlib plus main only)

1. **Free integers (§3.2, definition at line 93; lines 434–435, names line 446).** Integers
   `e_1, …, e_N` are free if `α, β ∈ ℕ^N` with `Σα_i = Σβ_i ≤ (N + 1)²` and `Σα_ie_i = Σβ_ie_i`
   are equal; lacunary and rapidly decreasing sequences are free. grh-lean
   `New.HasNoSmallRelations`, `New.hasNoSmallRelations_of_lacunary`,
   `New.hasNoSmallRelations_of_rapid_decrease`. Mathlib `Finsupp.weight`, `Finsupp.degree`.
   About 100 lines. File `TauCeti/Combinatorics/Additive/FreeIntegers.lean` (next to
   `NoRelation.lean`, a different predicate).
2. **Powers of a matrix via minors; a small factor of the charpoly (§4.1 prerequisite, lines
   486–511, method 495–500).** Over an integrally closed domain, if all order-`m` minors of
   `(y^0 … y^{m−1})` vanish, then `charpoly y = p * q` with `natDegree p < m` and `p(y) = 0`.
   grh-lean `New.powMinor`, `New.exists_factor_charpoly`,
   `New.det_eval_eq_zero_iff_not_linearIndependent`. Mathlib `linearIndependent_pow`,
   `Matrix.minpoly_dvd_charpoly`, `IsIntegrallyClosed.eq_map_mul_C_of_dvd`. About 120–150
   lines. File `TauCeti/LinearAlgebra/Matrix/Charpoly/PowMinor.lean`.
3. **Root quotients at a unitary matrix (§5.6(d), lines 806–808; definition line 644, twisted
   norm line 633).** `a` is a root quotient of `z` at `γ` if `a·z(γ)ᴴ = z(γ)`. If `z(γ)` is
   invertible, `z` has exactly one unitary root quotient at `γ`, and root quotients multiply;
   if `a` is a root quotient of `z` at `γ`, `γ` one of `N_σ(z)` at `γ`, and `γc = cσ(γ)`, then
   `N_σ(c) = γ·N_σ(a⁻¹c)`. grh-lean `New.IsRootQuotient`, `New.U.existsUnique_isRootQuotient`,
   `New.IsRootQuotient.mul`, `New.IsRootQuotient.twistedNorm_eq_mul`. Builds on
   TauCeti/Algebra/Group/Hom/TwistedNorm.lean and
   TauCeti/LinearAlgebra/Matrix/GeneralLinearGroup/Unitary.lean. About 150–200 lines.
4. **Orbit weights summing to `c` (§9.1(b), lines 1436–1437, method 1418–1420).** A finite `Δ`
   acting on `X` with every stabiliser order dividing `c` has `u : X → ℕ` with
   `Σ_d u(d•x) = c`; multiplication by `u` is an operator `Ψ` with `Σ_g g⁻¹Ψg = c`. grh-lean
   `New.Patching.exists_orbit_weight` (core of `New.Patching.BaseLevel.exists_higman_operator`).
   Builds on `TauCeti.cardStabilizerOnOrbit` (GroupTheory/DoubleCoset/Mass.lean). About 100–150
   lines. File `TauCeti/GroupTheory/GroupAction/Orbit/StabilizerWeight.lean` (the existing
   `Orbit/Weight.lean` is a different notion).
5. **Approximating monoids from uniform closures (§2.4(a), lines 380–387).** grh-lean
   `New.uniformClosure`, `New.IsApproximatingMonoid`,
   `New.exists_isApproximatingMonoid_of_mem_uniformClosure`,
   `New.IsApproximatingMonoid.tendstoUniformly_eval`. Pure analysis, about 150–200 lines. File
   `TauCeti/Topology/Algebra/UniformConvergence/ApproximatingMonoid.lean`.
6. **Cancelling two disjoint families of characters (§2.1(e), lines 297–299).** grh-lean
   `New.IsTraceNondeg.exists_cancel_chars`. Use Mathlib's `IsSemisimpleRepresentation`: compare
   `r_0 ⊕ ⊕ψ_1` and `r_1 ⊕ ⊕ψ_0` by characters, count multiplicities, split the characters
   off. About 200–300 lines. File
   `TauCeti/RepresentationTheory/Semisimple/CharacterCancellation.lean`.

Backup: §2.1(d) (line 296), `ψ ⊗ r` is semisimple, via
`Representation.subrepresentationCharTwistOrderIso` (RepresentationTheory/Character/Twist.lean);
about 40 lines.

Excluded: §2.3 `newtonPoly` (Newton identities on main), §5.6(a) (no star structure on finite
adeles), §5.2 profinite clauses (large), §7.1 `eval_heckePoly` (trivial).

A sparse clone of grh-lean (`lsernau/grh-lean` at `72fead1`, `grh/src/Lib`) has the reference
proofs; the roadmap allows following them with credit in a Provenance section, not copying.
