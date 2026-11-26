Roadmap: ShortGRH

Roadmap target on TauCetiRoadmap `main`: [`TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md` L426–L446](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L426-L446), §3.2 **Matrix coefficients of free weights are dense**, which uses that lacunary and rapidly decreasing sequences are free ([L433–L435](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L433-L435); reference names `New.hasNoSmallRelations_of_lacunary`, `New.hasNoSmallRelations_of_rapid_decrease` at L446), with free integers as defined in the glossary ([L93](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L93)). This PR supplies the definition and these sufficient conditions. Free dominant weights and the density theorem of §3.2 remain, so the target marker below is partial.

### Summary

New file `TauCeti/Combinatorics/Additive/FreeIntegers.lean`, namespace `TauCeti`.

- `HasNoSmallRelations B e`, for `e : ι → M` with `M` an additive commutative monoid: vectors `α, β : ι →₀ ℕ` with `α.degree = β.degree ≤ B` and `Finsupp.weight e α = Finsupp.weight e β` are equal. Integers `e : Fin N → ℤ` are free in the sense of the glossary if and only if `HasNoSmallRelations ((N + 1) ^ 2) e`.
- `HasNoSmallRelations.mono`: the predicate passes to smaller bounds.
- `Finsupp.weight_comp`, `hasNoSmallRelations_comp_iff`, `hasNoSmallRelations_neg_iff`: the predicate is invariant under composition with an injective additive homomorphism, in particular under negation.
- `Finsupp.weight_add_const`, `hasNoSmallRelations_add_const_iff`: the weight of `e + c` at `α` is `weight e α + α.degree • c`, so the predicate is invariant under translation in a cancellative monoid. This covers the shift `λ_i + N − i` of the glossary.
- `weight_lt_weight_of_toLex_lt`: for `y : ι → ℤ` nonnegative, `ι` linearly ordered, and `B * y j < y i` whenever `i < j`, the weight is strictly monotone for the lexicographic order on vectors of the same degree at most `B`.
- `hasNoSmallRelations_of_rapid_decrease`: such a family has no small relations up to `B`.
- `hasNoSmallRelations_of_lacunary`: nonnegative `y` with `B * y i < y j` whenever `i < j` have no small relations up to `B`; this is the previous theorem on `ιᵒᵈ`.

Departures from the reference: the bound `(n + 1) ^ 2` is a parameter `B`; the index type is any linear order; the gap condition `B * y j < y i` is weaker than `y j < y i / (n + 1) ^ 2`. The reference's `New.hasNoSmallRelations_of_rapid_decrease` concerns one explicit weight; its proof checks the gap condition for that weight and applies the lacunary lemma, so it belongs with the construction of the weights of §3.2 and is not ported here. The module docstring credits grh-lean in a Provenance paragraph.

### Verification

- `lake build --iofail TauCeti.Combinatorics.Additive.FreeIntegers` with the repository's `leanOptions`: no warnings. The PR adds one file and changes no existing module, so there are no downstream importers.
- `#print axioms` for the nine public declarations: `propext`, `Classical.choice`, `Quot.sound` only.
- Mathlib's `#lint` on the module: 12 declarations, no findings.
- `lake lint` was not run: in the shallow clone it stops with the message that the local check scope cannot be determined from shallow history. CI runs it.
- No `sorry`, `set_option`, macros or double quotes in comments; every line has at most 100 characters.

Quality pass:
- Q1 Mathlib duplicates: checked — `Mathlib/Combinatorics/Additive/Dissociation.lean` (`AddDissociated`) concerns `0`/`1` coefficients without a degree condition, a different notion; `Finsupp.weight`, `Finsupp.degree` and `Finsupp.Lex.lt_iff` are reused; Mathlib has no composition or translation lemma for `Finsupp.weight`.
- Q2 Tau Ceti duplicates, on main and in open PRs: checked — `TauCeti/Combinatorics/Additive/NoRelation.lean` (`NoRelation`, a three-term relation on sets) and `TauCeti/NumberTheory/DiophantineApproximation/Roth/Lacunary.lean` are different statements; searched main and open PRs for `HasNoSmallRelations`, free integers and lacunary sequences: none.
- Q3 Hypotheses: checked — kept, with counterexamples: `hy` (`y = (1, 0, -1)`, `B = 2`: `(1, 0, 1)` and `(0, 2, 0)` have degree `2` and weight `0`); `h_gap` (`y = (2, 1, 0)`, `B = 2` satisfies the non-strict gap, and `(0, 2, 0)`, `(1, 0, 1)` have weight `2`); `h_deg` in `weight_lt_weight_of_toLex_lt` (`y = (3, 1)`, `B = 1`, `α = (0, 5)`, `β = (1, 0)`: weights `5` and `3`); `hB` there (`y = (5, 2, 0)`, `B = 2`, `α = (0, 3, 0)`, `β = (1, 0, 2)`: weights `6` and `5`); `hf` in `hasNoSmallRelations_comp_iff` (`f = 0` with two indices); `[AddCancelCommMonoid M]` in `hasNoSmallRelations_add_const_iff` (`M = ℕ∞`, `c = ⊤`, `e = (0, 1)`: `e` has no small relations up to `1`, while `e + ⊤` is constant); `[LinearOrder ι]` (needed to state the gap conditions). No finiteness of `ι` is assumed.
- Q4 Section variables: checked — the only `variable` line is `{ι M M' : Type*}`; each declaration states its own instance arguments.
- Q5 Proofs of at most 50 lines: checked — the longest proof, of the private `sum_mul_lt_sum_mul`, has 29 lines; `weight_lt_weight_of_toLex_lt` has 22.

<!--tauceti-target:v1 {"focus":"ShortGRH","id":"GaloisRepresentationsOfUnitaryEigenforms/3.2","partial":true}-->

🤖 Generated with [Claude Code](https://claude.com/claude-code)

https://claude.ai/code/session_01HH3uUYkPpqrzJ2jFRJh8H7
