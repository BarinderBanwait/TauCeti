Roadmap: ShortGRH

Roadmap target on TauCetiRoadmap `main`: [`TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md` L296](https://github.com/TauCetiProject/TauCetiRoadmap/blob/989785430bd24f7c8fb622a3cb341a947247abde/TauCetiRoadmap/ShortGRH/GaloisRepresentationsOfUnitaryEigenforms/README.md#L296), §2.1 part (d): for a character `ψ : G → k^×`, `ψ ⊗ r` is semisimple. This PR proves (d), in both directions, for the twist `Representation.charTwist` and for the tensor product with the one-dimensional representation on either side. The roadmap's hypotheses that `k` is algebraically closed of characteristic `0` are not used. Parts (a) and (b) of §2.1 are on main; (c) and (e) are separate, so the target marker below is partial.

### Summary

New file `TauCeti/RepresentationTheory/Character/Twist/Semisimple.lean`, namespace `Representation`, for `[Field k] [Monoid G] [AddCommGroup V] [Module k V]`, `χ : G →* kˣ` and `ρ : Representation k G V`.

- `isSemisimpleRepresentation_charTwist_iff` (`@[simp]`): `charTwist χ ρ` is semisimple if and only if `ρ` is. It follows from `subrepresentationCharTwistOrderIso`, an order isomorphism of the lattices of subrepresentations, by `OrderIso.complementedLattice_iff`.
- `isSemisimpleRepresentation_ofLinearCharacter_tprod_iff`, `isSemisimpleRepresentation_tprod_ofLinearCharacter_iff` (`@[simp]`): the same for `(ofLinearCharacter χ).tprod ρ` and `ρ.tprod (ofLinearCharacter χ)`, through the equivalences `tprodEquivCharTwist` and `tprodOfLinearCharacterEquivCharTwist` and `IntertwiningMap.isSemisimpleRepresentation_of_surjective`.
- Instances `isSemisimpleRepresentation_charTwist`, `isSemisimpleRepresentation_ofLinearCharacter_tprod`, `isSemisimpleRepresentation_tprod_ofLinearCharacter`: the forward directions as instances.

The file is new rather than an addition to `TauCeti/RepresentationTheory/Character/Twist.lean`, since the proofs import `TauCeti.RepresentationTheory.Subrepresentation.Semisimple` and `Twist.lean` has 19 direct importers.

### Verification

- `lake build --iofail TauCeti.RepresentationTheory.Character.Twist.Semisimple` with the repository's `leanOptions`: no warnings. The PR adds one file and changes no existing module, so there are no downstream importers.
- `#print axioms` for the six declarations: `propext`, `Classical.choice`, `Quot.sound` only.
- Mathlib's `#lint` on the module: 15 linters, no findings.
- `lake lint` was not run: in the shallow clone it stops with the message that the local check scope cannot be determined from shallow history. CI runs it.
- No `sorry`, `set_option`, macros or double quotes in comments; every line has at most 100 characters.

Quality pass:
- Q1 Mathlib duplicates: checked — Mathlib's `Mathlib/RepresentationTheory/Semisimple.lean` has the definition of `IsSemisimpleRepresentation` and its characterisation through `asModule`, and no statement about twists or tensor products with characters.
- Q2 Tau Ceti duplicates, on main and in open PRs: checked — searched main for `IsSemisimpleRepresentation` together with `charTwist`, `tprod` and `tensor`, and open PRs for semisimplicity of twists and tensor products: none. Reused: `subrepresentationCharTwistOrderIso`, `tprodEquivCharTwist`, `tprodOfLinearCharacterEquivCharTwist`, `IntertwiningMap.isSemisimpleRepresentation_of_surjective`.
- Q3 Hypotheses: checked — dropped: the roadmap's algebraically closed and characteristic `0` hypotheses. `[Field k]` is needed to state `IsSemisimpleRepresentation`, which Mathlib defines over a field; `[Monoid G] [AddCommGroup V] [Module k V]` are needed to state `Representation k G V`. The iff statements have no further hypotheses; each instance assumes only the semisimplicity it transports.
- Q4 Section variables: checked — the single `variable` block `{k G V : Type*} [Field k] [Monoid G] [AddCommGroup V] [Module k V] (χ : G →* kˣ) (ρ : Representation k G V)` is used by every declaration.
- Q5 Proofs of at most 50 lines: checked — each proof has at most 4 lines.

<!--tauceti-target:v1 {"focus":"ShortGRH","id":"GaloisRepresentationsOfUnitaryEigenforms/2.1","partial":true}-->

🤖 Generated with [Claude Code](https://claude.com/claude-code)

https://claude.ai/code/session_01HH3uUYkPpqrzJ2jFRJh8H7
