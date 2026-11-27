Roadmap: ShortGRH

Roadmap target on TauCetiRoadmap `main`: [`TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md` L297–L299](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L297-L299), §2.1 part (e): for semisimple `r_0, r_1 : G → GL_{n+t}(k)` and characters `ψ_{0,l} ≠ ψ_{1,l′}`, if `tr r_i − Σ_l ψ_{i,l}` is the same function `T` for `i = 0, 1`, then `T = tr s` for a semisimple `s : G → GL_n(k)`. This PR proves (e) over any field of characteristic `0`, for a monoid `G`, with families of possibly different sizes, and without semisimplicity or finite dimension of `ρ₀, ρ₁`. Parts (a), (b) and (d) are on main or in their own PRs and (c) is held elsewhere, so the target marker below is partial for §2.1.

### Summary

New file `TauCeti/RepresentationTheory/Semisimple/CharacterCancellation.lean`, namespace `Representation`, `[Field k] [Monoid G]`. Write `Ψ` for `pi fun i ↦ ofLinearCharacter (ψ i)`, the direct sum of the lines of a family `ψ : ι → G →* kˣ`.

- `char_pi` (`@[simp]`): the character of a finite product of finite-dimensional representations is the sum of the characters.
- `char_pi_ofLinearCharacter`: the character of `Ψ` is `∑ i, ψ i`.
- Instance `isSemisimpleRepresentation_pi_ofLinearCharacter`: `Ψ` is semisimple for finite `ι`.
- `IntertwiningMap.eq_zero_of_pi_ofLinearCharacter`: an intertwining map `Ψ₀ → Ψ₁` between the line sums of families with `ψ₀ i ≠ ψ₁ j` for all `i, j`, `ι₀` finite, is zero.
- `exists_fdRep_isSemisimpleRepresentation_character_eq`: every representation has a semisimple `FDRep` with the same character and `Module.finrank`: the semisimplification if it is finite-dimensional, the zero representation otherwise.
- `exists_injective_intertwiningMap_pi_ofLinearCharacter`: in characteristic `0`, for `ρ₀` finite-dimensional semisimple and `χ_{ρ₀} − ∑ ψ₀ = χ_{ρ₁} − ∑ ψ₁` with the families disjoint, `Ψ₀` embeds into `ρ₀`. By `nonempty_equiv_of_character_eq_of_isSemisimpleRepresentation` (§2.1 (b)), `ρ₁^ss ⊕ Ψ₀ ≃ ρ₀ ⊕ Ψ₁`; restricted to `Ψ₀` the `Ψ₁` component is zero, so the `ρ₀` component is injective.
- `exists_isSemisimpleRepresentation_character_eq_sub_sum`: under these hypotheses, for arbitrary `ρ₀, ρ₁`, there is a semisimple `s : FDRep k G` with `χ_s = χ_{ρ₀} − ∑ i, ψ₀ i` and `finrank s + card ι₀ = finrank V₀`. The representation `s` is an invariant complement of the image of `Ψ₀`.

The module docstring names grh-lean `New.IsTraceNondeg.exists_cancel_chars` as the corresponding statement; the proof here is independent of it. `char_pi` and `exists_fdRep_isSemisimpleRepresentation_character_eq` are general lemmas; they are placed here because `TauCeti/RepresentationTheory/Pi/Basic.lean` and `TauCeti/RepresentationTheory/Semisimplification.lean` lack the imports they need.

### Verification

- `lake build --iofail TauCeti.RepresentationTheory.Semisimple.CharacterCancellation` with the repository's `leanOptions`: no warnings. The PR adds one file and changes no existing module, so there are no downstream importers.
- `#print axioms` for the seven declarations: `propext`, `Classical.choice`, `Quot.sound` only.
- Mathlib's `#lint` on the module: 15 linters, no findings.
- `lake lint` was not run: in the shallow clone it stops with the message that the local check scope cannot be determined from shallow history. CI runs it.
- No `sorry`, `set_option`, macros or double quotes in comments; every line has at most 100 characters.

Quality pass:
- Q1 Mathlib duplicates: checked — searched Mathlib for the character of a product of representations, semisimplicity of sums of lines and cancellation of characters: none. Reused: `LinearMap.trace_piMap`.
- Q2 Tau Ceti duplicates, on main and in open PRs: checked — searched main for `char_pi`, `character_pi`, semisimplicity of `pi` and `directSum`, finrank of the semisimplification and cancellation lemmas: none (`char_directSum` is for `directSum`). Reused: `char_ofLinearCharacter`, `isSemisimpleRepresentation_of_span_eq_top`, `nonempty_equiv_of_character_eq_of_isSemisimpleRepresentation`, `char_semisimplification`, `charpoly_semisimplification_apply`, `IntertwiningMap.equivOfRange`, `Subrepresentation.char_add_eq_of_isCompl`, `character_eq_zero_of_not_finite`, `FDRep.ofShrink`, `char_prod`. Searched open PRs for cancellation of characters: none; #46673 concerns (b) and #46059 concerns (c).
- Q3 Hypotheses: declined — `[FiniteDimensional k V₀]` in `exists_injective_intertwiningMap_pi_ofLinearCharacter` is unresolved (the hypotheses then appear to force `ι₀` empty; not proved). Dropped from the roadmap: algebraic closure of `k`, `G` a group, semisimplicity and finite dimension of `ρ₀, ρ₁` in the main theorem, equal sizes of the families. Kept, with counterexamples: `[Finite ι₀]` in `eq_zero_of_pi_ofLinearCharacter` and `[Finite ι]` in the instance (`G = ⊕_ℕ ℤ/2` over `ℚ`, `ψ₀ n` the sign of coordinate `n`, `ψ₁` trivial: a nonzero functional on `∏ ℚ` vanishing on `⊕ ℚ` is a nonzero intertwining map, and `⊕ ℚ ⊆ ∏ ℚ` has no invariant complement); `[∀ i, FiniteDimensional k (V i)]` in `char_pi` (`ι = Bool`, a trivial line and an infinite-dimensional trivial representation: `0 ≠ 1`); `[CharZero k]` (trivial `G`, `ρ₀ = ρ₁ = 0`, `ψ₀` consisting of `p` copies of `1`, `ψ₁` empty, in characteristic `p`: the hypothesis holds but no `p`-dimensional space embeds in `0`, and `finrank s + p = 0` fails); `[ρ₀.IsSemisimpleRepresentation]` in the embedding lemma (`G` the matrices `[[a, b], [0, 1]]` in `GL₂(ℚ)` on `ℚ²`, `ψ₀ = (1)`, `ρ₁` the line of `a`, `ψ₁` empty: no nonzero fixed vector); `hne` (`ρ₀ = ρ₁ = 0`, `ψ₀ = ψ₁ = (1)`: `T = −1` is not a character in characteristic `0`); `[Fintype ι₀] [Fintype ι₁]` (needed to state the sums).
- Q4 Section variables: checked — `(ψ : ι → G →* kˣ)` is a variable of the section `LineSum` only; `[AddCommGroup V₀] [Module k V₀] [AddCommGroup V₁] [Module k V₁]` are introduced after `eq_zero_of_pi_ofLinearCharacter`, and the environment linters report no unused arguments.
- Q5 Proofs of at most 50 lines: checked — the longest proof, `exists_isSemisimpleRepresentation_character_eq_sub_sum`, has 20 lines; the others have at most 17.

<!--tauceti-target:v1 {"focus":"ShortGRH","id":"GaloisRepresentationsOfUnitaryEigenforms/2.1","partial":true}-->

🤖 Generated with [Claude Code](https://claude.com/claude-code)

https://claude.ai/code/session_01HH3uUYkPpqrzJ2jFRJh8H7
