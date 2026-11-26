Roadmap: ShortGRH

Roadmap target on TauCetiRoadmap `main`: [`TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md` L486–L511](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L486-L511), §4.1 **Free weights force the rank and identify the characteristic polynomials**. Its method ([L494–L500](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L494-L500)) uses that linear dependence of the first powers of a matrix is the vanishing of minors, and that no factor of the characteristic polynomial of degree below `n` kills `r(s_v)`. This PR supplies these two prerequisites, `New.powMinor` and `New.exists_factor_charpoly` of the reference listed at L511. The rest of §4.1 remains, so the target marker below is partial.

### Summary

New file `TauCeti/LinearAlgebra/Matrix/Charpoly/PowMinor.lean`, namespace `Matrix`, for `y : Matrix N N R` with `[Fintype N] [DecidableEq N] [CommRing R]`.

- `powMinor y m a`: the `m × m` minor, at the rows `a : Fin m → N × N`, of the matrix whose column `j < m` lists the entries of `y ^ j`.
- `powMinor_map` (`@[simp]`): `(y.map f).powMinor m a = f (y.powMinor m a)` for a ring homomorphism `f`.
- `forall_powMinor_eq_zero_iff`: over an integral domain, all `powMinor y m a` vanish if and only if `1, y, …, y ^ (m - 1)` are linearly dependent over `R`. It reduces to `Matrix.linearIndependent_row_iff_exists_det_submatrix_ne_zero` (`TauCeti/LinearAlgebra/Matrix/Rank.lean`); a non-injective `a` gives two equal columns.
- `exists_monic_dvd_charpoly_of_not_linearIndependent`: over an integrally closed domain, if `1, y, …, y ^ (m - 1)` are linearly dependent, then `y.charpoly = p * q` with `p` monic, `natDegree p < m` and `aeval y p = 0`. The minimal polynomial of `y` over the fraction field has degree below `m` and divides the characteristic polynomial; Gauss's lemma (`IsIntegrallyClosed.eq_map_mul_C_of_dvd`) lifts it to a monic factor over `R`.

Departures from the reference: linear independence is over `R`, not over a field; the factor is stated to be monic; the hypothesis of the charpoly theorem is linear dependence, which `forall_powMinor_eq_zero_iff` converts from the vanishing of the minors. The module docstring credits grh-lean in a Provenance paragraph.

### Verification

- `lake build --iofail TauCeti.LinearAlgebra.Matrix.Charpoly.PowMinor` with the repository's `leanOptions`: no warnings. The PR adds one file and changes no existing module, so there are no downstream importers.
- `#print axioms` for the four public declarations: `propext`, `Classical.choice`, `Quot.sound` only.
- Mathlib's `#lint` on the module: 15 linters, 8 declarations, no findings.
- `lake lint` was not run: in the shallow clone it stops with the message that the local check scope cannot be determined from shallow history. CI runs it.
- No `sorry`, `set_option`, macros or double quotes in comments; every line has at most 100 characters.

Quality pass:
- Q1 Mathlib duplicates: checked — searched Mathlib for minors of the powers of a matrix and for factors of the characteristic polynomial killing the matrix (none). `minpoly.isIntegrallyClosed_eq_field_fractions'` would give the factor directly but needs `IsDomain` of the algebra, which a matrix algebra is not; the proof uses `Matrix.minpoly_dvd_charpoly`, `Matrix.charpoly_map`, `linearIndependent_pow` and Gauss's lemma.
- Q2 Tau Ceti duplicates, on main and in open PRs: checked — on main, `TauCeti/LinearAlgebra/Matrix/Rank.lean` has the equivalence between linear independence of rows and a nonzero maximal minor over a domain; it is reused, not restated. No declaration on main or in an open PR (searched for `powMinor`, minors of matrix powers, charpoly factors) has these statements.
- Q3 Hypotheses: declined — `[IsDomain R]` in `exists_monic_dvd_charpoly_of_not_linearIndependent` is unresolved: the proof passes to the fraction field, and I have no counterexample without it. Kept, with counterexamples: `[IsDomain R]` in `forall_powMinor_eq_zero_iff` (over `ℤ/4`, `y = diag(0, 2)` has `2 • y = 0`, so `1, y` are dependent, but the minor at the rows `(0, 0), (1, 1)` is `det [[1, 0], [1, 2]] = 2`); `[IsIntegrallyClosed R]` (`R = ℤ[2i]`, `y = diag(A, A')` with `A = [[0, -1], [1, 0]]` and `A'` of trace `2` and determinant `1 + 2i`: the minimal polynomial over `ℚ(i)` is `(X² + 1)(X - 2 + i)`, so `1, y, y², y³` are dependent, and a monic `p` of degree below `4` with `p(y) = 0` equals it, whose coefficient `i - 2` is not in `R`); `[Fintype N] [DecidableEq N]` (needed to state `det` and `charpoly`). `powMinor_map` has no hypotheses beyond the ring structures.
- Q4 Section variables: checked — the file has one `variable` line, `{N R S : Type*} [Fintype N] [DecidableEq N] [CommRing R] [CommRing S]`; `S` enters only `powMinor_map`, and the environment linters report no unused arguments.
- Q5 Proofs of at most 50 lines: checked — the longest proof, `exists_monic_dvd_charpoly_of_not_linearIndependent`, has 26 lines; the others have at most 9.

<!--tauceti-target:v1 {"focus":"ShortGRH","id":"GaloisRepresentationsOfUnitaryEigenforms/4.1","partial":true}-->

🤖 Generated with [Claude Code](https://claude.com/claude-code)

https://claude.ai/code/session_01HH3uUYkPpqrzJ2jFRJh8H7
