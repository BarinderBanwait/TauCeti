Roadmap: ShortGRH

Roadmap target on TauCetiRoadmap `main`: [`TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md` L806–L808](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L806-L808), §5.6 part (d): if `z(γ)` is invertible, `z` has exactly one unitary root quotient at `γ`, and root quotients multiply; if moreover `a` is a root quotient of `z` at `γ`, `γ` is a root quotient of `N_σ(z)` at `γ`, and `γc = cσ(γ)`, then `N_σ(c) = γ·N_σ(a⁻¹c)`. Root quotients are defined in §5.1 ([L644](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L644)). This PR proves the three clauses of (d) for a star algebra `A` over a commutative semiring `R`; the roadmap's setting is `A` the matrices over the finite adeles with the conjugate transpose and `τ = σ.mapMatrix`. The specialisation to matrices and parts (a)–(c) of §5.6 remain, so the target marker below is partial.

### Summary

New file `TauCeti/Algebra/Star/RootQuotient.lean`, namespace `Polynomial`, for `[CommSemiring R] [Semiring A] [Algebra R A] [StarRing A]`.

- `IsRootQuotient z x a`: `a * star (aeval x z) = aeval x z`.
- `commute_star_aeval_aeval`: for normal `x`, `star (aeval x z)` commutes with `aeval x w`.
- `IsRootQuotient.mul`: at normal `x`, root quotients of `z` and `w` multiply to a root quotient of `z * w`.
- `IsRootQuotient.eq_of_isUnit`: if `aeval x z` is a unit, root quotients of `z` at `x` are unique.
- `existsUnique_isRootQuotient`: if `x` is normal and `aeval x z` is a unit, `z` has exactly one root quotient at `x` in `unitary A`.
- `aeval_eq_mul_mul_star_of_mul_eq_mul`, `IsRootQuotient.conj`: if `x * c = c * y` for a unitary `c`, then `aeval x z = c * aeval y z * star c`, and conjugation by `c` carries root quotients at `y` to root quotients at `x`.
- `IsRootQuotient.map`: a ring homomorphism commuting with `star` and acting on scalars through `φ` carries root quotients of `z` to root quotients of `z.map φ`.
- `IsRootQuotient.isUnit_and_isRootQuotient_twistedNorm`, `IsRootQuotient.twistedNorm_eq_mul`: let `τ` be a ring endomorphism of `A` commuting with `star` and acting on scalars through `σ`. For unitary `γ, a, c` with `a` a root quotient of `z` at `γ`, `aeval γ z` a unit and `γ * c = c * τ γ`, the quotient `N_q(c) * N_q(a⁻¹ * c)⁻¹` is a root quotient of `N_q(z)` at `γ` for every `q`, by induction on `q`; with uniqueness this gives `N_p(c) = γ * N_p(a⁻¹ * c)` when `γ` is a root quotient of `N_p(z)` at `γ`. Twisted norms are `MonoidHom.twistedNorm` (`TauCeti/Algebra/Group/Hom/TwistedNorm.lean`), under `Polynomial.mapRingHom σ` and under `Unitary.map τ`.

A unitary `γ` is normal, so `existsUnique_isRootQuotient` covers the roadmap's unitary `γ`. The hypothesis `γc = cσ(γ)` is stated as an equation in `A`. The module docstring credits grh-lean in a Provenance paragraph.

### Verification

- `lake build --iofail TauCeti.Algebra.Star.RootQuotient` with the repository's `leanOptions`: no warnings. The PR adds one file and changes no existing module, so there are no downstream importers.
- `#print axioms` for the ten declarations: `propext`, `Classical.choice`, `Quot.sound` only.
- Mathlib's `#lint` on the module: 15 linters, no findings.
- `lake lint` was not run: in the shallow clone it stops with the message that the local check scope cannot be determined from shallow history. CI runs it.
- No `sorry`, `set_option`, macros or double quotes in comments; every line has at most 100 characters.

Quality pass:
- Q1 Mathlib duplicates: checked — searched Mathlib for root quotients, for commutation of `star` with `aeval` and for `IsStarNormal` with `aeval` (none; `RCLike.aeval_conj` is a different statement). Reused: `Polynomial.map_aeval_eq_aeval_map`, `Unitary.conjStarAlgAut`, `Unitary.map`, `Algebra.commute_of_mem_adjoin_singleton_of_commute`, `Polynomial.aeval_mem_adjoin_singleton`.
- Q2 Tau Ceti duplicates, on main and in open PRs: checked — searched main and open PRs for `IsRootQuotient` and root quotients: none. Reused: `MonoidHom.twistedNorm`, `MonoidHom.twistedNorm_succ`, `Units.mem_unitary_iff_star_eq_inv` (`TauCeti/Algebra/Star/Unitary.lean`).
- Q3 Hypotheses: checked — kept, with counterexamples: `[IsStarNormal x]` in `commute_star_aeval_aeval` and `IsRootQuotient.mul` (`x = [[1, 1], [0, 1]]`, `z = w = X`: `star x` does not commute with `x`, and `a = x (xᴴ)⁻¹` has `a² ≠ x² (x²ᴴ)⁻¹`); `hz` in `eq_of_isUnit` and `existsUnique_isRootQuotient` (`z = 0`: every element is a root quotient); `[IsStarNormal x]` in `existsUnique_isRootQuotient` (for invertible non-normal `x` and `z = X` the only root quotient `x (xᴴ)⁻¹` is not unitary); `hτ` in `map` (`R = A = B = ℂ`, `τ` complex conjugation, `φ = id`, `z = e^{iπ/4}`, `x = 1`: `a = i`, but `τ a = -i` is not a root quotient); `hτ_star` in `map` (`R = ℝ`, `τ = id : ℂ → ℂ` with the trivial star on the target, `z = X`, `x = i`: `a = -1`, while the target needs `1`); in `twistedNorm_eq_mul`: `hγ` (`A = ℂ`, `p = 1`, `z = 1`, `a = c = 1`, `γ = -1`, `τ = id`: `1 = -1`), `hc` (`R = A = ℂ`, `σ = τ` complex conjugation, `p = 2`, `z = X`, `γ = ω` a primitive cube root of unity, `a = ω²`: the sides are `1` and `ω`), `ha` (`p = 1`: the conclusion forces `γ = a`), `hz` (`z = 0`, `p = 1`, `γ = c = 1`, `a = -1`: `1 = -1`), `hτ` (`R = A = ℂ`, `σ = id`, `τ` complex conjugation, `p = 2`, `z = e^{iπ/4}`, `γ = -1`, `a = i`, `c = 1`: `1 = -1`); `hτ_star` is needed to state `Unitary.map`. Unitarity of `c` in `conj` and of `γ, a, c` in the twisted-norm theorems is part of their types; for merely invertible `c` over `ℂ`, `conj` would need `|c|² = 1`. No `StarModule R A` is assumed.
- Q4 Section variables: checked — the section variables `hτ` and `hτ_star` enter only the two twisted-norm theorems, through `include hτ in` and the statements; the environment linters report no unused arguments.
- Q5 Proofs of at most 50 lines: checked — the longest proof, `isUnit_and_isRootQuotient_twistedNorm`, has 23 lines; `existsUnique_isRootQuotient` has 12; the others have at most 4.

<!--tauceti-target:v1 {"focus":"ShortGRH","id":"GaloisRepresentationsOfUnitaryEigenforms/5.6","partial":true}-->

🤖 Generated with [Claude Code](https://claude.com/claude-code)

https://claude.ai/code/session_01HH3uUYkPpqrzJ2jFRJh8H7
