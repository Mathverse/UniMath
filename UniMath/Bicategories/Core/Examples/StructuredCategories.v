(***********************************************************************************

 Bicategories of categories with structure

 We define a number of bicategories whose objects are categories with a certain
 structure and whose 1-cells are functors preserving that structure. The 2-cells
 are just natural transformations.

 Contents
 1. Categories with a terminal object
 2. Categories with binary products
 3. Categories with pullbacks
 4. Categories with finite limits
 5. Categories with an initial object
 6. Categories with binary coproducts

 ***********************************************************************************)
Require Import UniMath.Foundations.All.
Require Import UniMath.MoreFoundations.All.
Require Import UniMath.CategoryTheory.Core.Prelude.
Require Import UniMath.CategoryTheory.Limits.Terminal.
Require Import UniMath.CategoryTheory.Limits.BinProducts.
Require Import UniMath.CategoryTheory.Limits.Pullbacks.
Require Import UniMath.CategoryTheory.Limits.Initial.
Require Import UniMath.CategoryTheory.Limits.BinCoproducts.
Require Import UniMath.CategoryTheory.Limits.Preservation.
Require Import UniMath.CategoryTheory.DisplayedCats.Core.
Require Import UniMath.CategoryTheory.DisplayedCats.Univalence.
Require Import UniMath.Bicategories.Core.Bicat. Import Bicat.Notations.
Require Import UniMath.Bicategories.Core.Examples.BicatOfUnivCats.
Require Import UniMath.Bicategories.DisplayedBicats.DispBicat. Import DispBicat.Notations.
Require Import UniMath.Bicategories.DisplayedBicats.DispUnivalence.
Require Import UniMath.Bicategories.DisplayedBicats.Examples.Sub1Cell.
Require Import UniMath.Bicategories.DisplayedBicats.Examples.Prod.

Local Open Scope cat.

(**
 1. Categories with a terminal object
 *)
Definition disp_bicat_terminal_obj
  : disp_bicat bicat_of_univ_cats.
Proof.
  use disp_subbicat.
  - exact (λ C, Terminal (pr1 C)).
  - exact (λ C₁ C₂ _ _ F, preserves_terminal F).
  - exact (λ C _, identity_preserves_terminal _).
  - exact (λ _ _ _ _ _ _ _ _ HF HG, composition_preserves_terminal HF HG).
Defined.

Definition univ_cat_with_terminal_obj
  : bicat
  := total_bicat disp_bicat_terminal_obj.

Definition disp_univalent_2_1_disp_bicat_terminal_obj
  : disp_univalent_2_1 disp_bicat_terminal_obj.
Proof.
  use disp_subbicat_univalent_2_1.
  intros.
  apply isaprop_preserves_terminal.
Qed.

Definition disp_univalent_2_0_disp_bicat_terminal_obj
  : disp_univalent_2_0 disp_bicat_terminal_obj.
Proof.
  use disp_subbicat_univalent_2_0.
  - exact univalent_cat_is_univalent_2.
  - intro C.
    apply isaprop_Terminal.
    exact (pr2 C).
  - intros.
    apply isaprop_preserves_terminal.
Qed.

Definition disp_univalent_2_disp_bicat_terminal_obj
  : disp_univalent_2 disp_bicat_terminal_obj.
Proof.
  split.
  - exact disp_univalent_2_0_disp_bicat_terminal_obj.
  - exact disp_univalent_2_1_disp_bicat_terminal_obj.
Defined.

Definition is_univalent_2_1_univ_cat_with_terminal_obj
  : is_univalent_2_1 univ_cat_with_terminal_obj.
Proof.
  use total_is_univalent_2_1.
  - exact univalent_cat_is_univalent_2_1.
  - exact disp_univalent_2_1_disp_bicat_terminal_obj.
Defined.

Definition is_univalent_2_0_univ_cat_with_terminal_obj
  : is_univalent_2_0 univ_cat_with_terminal_obj.
Proof.
  use total_is_univalent_2_0.
  - exact univalent_cat_is_univalent_2_0.
  - exact disp_univalent_2_0_disp_bicat_terminal_obj.
Defined.

Definition is_univalent_2_univ_cat_with_terminal_obj
  : is_univalent_2 univ_cat_with_terminal_obj.
Proof.
  split.
  - exact is_univalent_2_0_univ_cat_with_terminal_obj.
  - exact is_univalent_2_1_univ_cat_with_terminal_obj.
Defined.

(**
 2. Categories with binary products
 *)
Definition disp_bicat_binprod
  : disp_bicat bicat_of_univ_cats.
Proof.
  use disp_subbicat.
  - exact (λ C, BinProducts (pr1 C)).
  - exact (λ C₁ C₂ _ _ F, preserves_binproduct F).
  - exact (λ C _, identity_preserves_binproduct _).
  - exact (λ _ _ _ _ _ _ _ _ HF HG, composition_preserves_binproduct HF HG).
Defined.

Definition univ_cat_with_binprod
  : bicat
  := total_bicat disp_bicat_binprod.

Definition disp_univalent_2_1_disp_bicat_binprod
  : disp_univalent_2_1 disp_bicat_binprod.
Proof.
  use disp_subbicat_univalent_2_1.
  intros.
  apply isaprop_preserves_binproduct.
Qed.

Definition disp_univalent_2_0_disp_bicat_binprod
  : disp_univalent_2_0 disp_bicat_binprod.
Proof.
  use disp_subbicat_univalent_2_0.
  - exact univalent_cat_is_univalent_2.
  - intro C.
    use impred ; intro x.
    use impred ; intro y.
    use isaprop_BinProduct.
    exact (pr2 C).
  - intros.
    apply isaprop_preserves_binproduct.
Defined.

Definition disp_univalent_2_disp_bicat_binprod
  : disp_univalent_2 disp_bicat_binprod.
Proof.
  split.
  - exact disp_univalent_2_0_disp_bicat_binprod.
  - exact disp_univalent_2_1_disp_bicat_binprod.
Defined.

Definition is_univalent_2_1_univ_cat_with_binprod
  : is_univalent_2_1 univ_cat_with_binprod.
Proof.
  use total_is_univalent_2_1.
  - exact univalent_cat_is_univalent_2_1.
  - exact disp_univalent_2_1_disp_bicat_binprod.
Defined.

Definition is_univalent_2_0_univ_cat_with_binprod
  : is_univalent_2_0 univ_cat_with_binprod.
Proof.
  use total_is_univalent_2_0.
  - exact univalent_cat_is_univalent_2_0.
  - exact disp_univalent_2_0_disp_bicat_binprod.
Defined.

Definition is_univalent_2_univ_cat_with_binprod
  : is_univalent_2 univ_cat_with_binprod.
Proof.
  split.
  - exact is_univalent_2_0_univ_cat_with_binprod.
  - exact is_univalent_2_1_univ_cat_with_binprod.
Defined.

(**
 3. Categories with pullbacks
 *)
Definition disp_bicat_pullback
  : disp_bicat bicat_of_univ_cats.
Proof.
  use disp_subbicat.
  - exact (λ C, Pullbacks (pr1 C)).
  - exact (λ C₁ C₂ _ _ F, preserves_pullback F).
  - exact (λ C _, identity_preserves_pullback _).
  - exact (λ _ _ _ _ _ _ _ _ HF HG, composition_preserves_pullback HF HG).
Defined.

Definition univ_cat_with_pb
  : bicat
  := total_bicat disp_bicat_pullback.

Definition disp_univalent_2_1_disp_bicat_pullback
  : disp_univalent_2_1 disp_bicat_pullback.
Proof.
  use disp_subbicat_univalent_2_1.
  intros.
  apply isaprop_preserves_pullback.
Qed.

Definition disp_univalent_2_0_disp_bicat_pullback
  : disp_univalent_2_0 disp_bicat_pullback.
Proof.
  use disp_subbicat_univalent_2_0.
  - exact univalent_cat_is_univalent_2.
  - intro C.
    repeat (use impred ; intro).
    apply isaprop_Pullback.
    exact (pr2 C).
  - intros.
    apply isaprop_preserves_pullback.
Qed.

Definition disp_univalent_2_disp_bicat_pullback
  : disp_univalent_2 disp_bicat_pullback.
Proof.
  split.
  - exact disp_univalent_2_0_disp_bicat_pullback.
  - exact disp_univalent_2_1_disp_bicat_pullback.
Defined.

Definition is_univalent_2_1_univ_cat_with_pb
  : is_univalent_2_1 univ_cat_with_pb.
Proof.
  use total_is_univalent_2_1.
  - exact univalent_cat_is_univalent_2_1.
  - exact disp_univalent_2_1_disp_bicat_pullback.
Defined.

Definition is_univalent_2_0_univ_cat_with_pb
  : is_univalent_2_0 univ_cat_with_pb.
Proof.
  use total_is_univalent_2_0.
  - exact univalent_cat_is_univalent_2_0.
  - exact disp_univalent_2_0_disp_bicat_pullback.
Defined.

Definition is_univalent_2_univ_cat_with_pb
  : is_univalent_2 univ_cat_with_pb.
Proof.
  split.
  - exact is_univalent_2_0_univ_cat_with_pb.
  - exact is_univalent_2_1_univ_cat_with_pb.
Defined.

(**
 4. Categories with finite limits
 *)
Definition disp_bicat_finlim
  : disp_bicat bicat_of_univ_cats
  := disp_dirprod_bicat
       disp_bicat_terminal_obj
       disp_bicat_pullback.

Definition bicat_of_univ_cat_with_finlim
  : bicat
  := total_bicat disp_bicat_finlim.

Definition disp_univalent_2_1_disp_bicat_finlim
  : disp_univalent_2_1 disp_bicat_finlim.
Proof.
  use is_univalent_2_1_dirprod_bicat.
  - exact disp_univalent_2_1_disp_bicat_terminal_obj.
  - exact disp_univalent_2_1_disp_bicat_pullback.
Qed.

Definition disp_univalent_2_0_disp_bicat_finlim
  : disp_univalent_2_0 disp_bicat_finlim.
Proof.
  use is_univalent_2_0_dirprod_bicat.
  - exact univalent_cat_is_univalent_2_1.
  - exact disp_univalent_2_disp_bicat_terminal_obj.
  - exact disp_univalent_2_disp_bicat_pullback.
Defined.

Definition disp_univalent_2_disp_bicat_finlim
  : disp_univalent_2 disp_bicat_finlim.
Proof.
  split.
  - exact disp_univalent_2_0_disp_bicat_finlim.
  - exact disp_univalent_2_1_disp_bicat_finlim.
Defined.

Definition is_univalent_2_1_bicat_of_univ_cat_with_finlim
  : is_univalent_2_1 bicat_of_univ_cat_with_finlim.
Proof.
  use total_is_univalent_2_1.
  - exact univalent_cat_is_univalent_2_1.
  - exact disp_univalent_2_1_disp_bicat_finlim.
Defined.

Definition is_univalent_2_0_bicat_of_univ_cat_with_finlim
  : is_univalent_2_0 bicat_of_univ_cat_with_finlim.
Proof.
  use total_is_univalent_2_0.
  - exact univalent_cat_is_univalent_2_0.
  - exact disp_univalent_2_0_disp_bicat_finlim.
Defined.

Definition is_univalent_2_bicat_of_univ_cat_with_finlim
  : is_univalent_2 bicat_of_univ_cat_with_finlim.
Proof.
  split.
  - exact is_univalent_2_0_bicat_of_univ_cat_with_finlim.
  - exact is_univalent_2_1_bicat_of_univ_cat_with_finlim.
Defined.

Definition univ_cat_with_finlim
  : UU
  := bicat_of_univ_cat_with_finlim.

Definition make_univ_cat_with_finlim
           (C : univalent_category)
           (T : Terminal C)
           (P : Pullbacks C)
  : univ_cat_with_finlim
  := C ,, (T ,, tt) ,, (P ,, tt).

Coercion univ_cat_of_univ_cat_with_finlim
         (C : univ_cat_with_finlim)
  : univalent_category
  := pr1 C.

Definition terminal_univ_cat_with_finlim
           (C : univ_cat_with_finlim)
  : Terminal C
  := pr112 C.

Definition pullbacks_univ_cat_with_finlim
           (C : univ_cat_with_finlim)
  : Pullbacks C
  := pr122 C.

Definition functor_finlim
           (C₁ C₂ : univ_cat_with_finlim)
  : UU
  := C₁ --> C₂.

Definition make_functor_finlim
           {C₁ C₂ : univ_cat_with_finlim}
           (F : C₁ ⟶ C₂)
           (FT : preserves_terminal F)
           (FP : preserves_pullback F)
  : functor_finlim C₁ C₂
  := F ,, (tt ,, FT) ,, (tt ,, FP).

Coercion functor_of_functor_finlim
         {C₁ C₂ : univ_cat_with_finlim}
         (F : functor_finlim C₁ C₂)
  : C₁ ⟶ C₂
  := pr1 F.

Definition functor_finlim_preserves_terminal
           {C₁ C₂ : univ_cat_with_finlim}
           (F : functor_finlim C₁ C₂)
  : preserves_terminal F
  := pr212 F.

Definition functor_finlim_preserves_pullback
           {C₁ C₂ : univ_cat_with_finlim}
           (F : functor_finlim C₁ C₂)
  : preserves_pullback F
  := pr222 F.

Definition nat_trans_finlim
           {C₁ C₂ : univ_cat_with_finlim}
           (F G : functor_finlim C₁ C₂)
  : UU
  := F ==> G.

Definition make_nat_trans_finlim
           {C₁ C₂ : univ_cat_with_finlim}
           {F G : functor_finlim C₁ C₂}
           (τ : F ⟹ G)
  : nat_trans_finlim F G
  := τ ,, (tt ,, tt) ,, (tt ,, tt).

Coercion nat_trans_of_nat_trans_finlim
         {C₁ C₂ : univ_cat_with_finlim}
         {F G : functor_finlim C₁ C₂}
         (τ : nat_trans_finlim F G)
  : F ⟹ G
  := pr1 τ.

Proposition nat_trans_finlim_eq
            {C₁ C₂ : univ_cat_with_finlim}
            {F G : functor_finlim C₁ C₂}
            {τ₁ τ₂ : nat_trans_finlim F G}
            (p : ∏ (x : C₁), τ₁ x = τ₂ x)
  : τ₁ = τ₂.
Proof.
  use subtypePath.
  {
    intro.
    use isapropdirprod ; use isapropdirprod ; exact isapropunit.
  }
  use nat_trans_eq.
  {
    apply homset_property.
  }
  exact p.
Qed.

(**
 5. Categories with an initial object
 *)
Definition disp_bicat_initial_obj
  : disp_bicat bicat_of_univ_cats.
Proof.
  use disp_subbicat.
  - exact (λ C, Initial (pr1 C)).
  - exact (λ C₁ C₂ _ _ F, preserves_initial F).
  - exact (λ C _, identity_preserves_initial _).
  - exact (λ _ _ _ _ _ _ _ _ HF HG, composition_preserves_initial HF HG).
Defined.

Definition univ_cat_with_initial
  : bicat
  := total_bicat disp_bicat_initial_obj.

Definition disp_univalent_2_1_disp_bicat_initial_obj
  : disp_univalent_2_1 disp_bicat_initial_obj.
Proof.
  use disp_subbicat_univalent_2_1.
  intros.
  apply isaprop_preserves_initial.
Qed.

Definition disp_univalent_2_0_disp_bicat_initial_obj
  : disp_univalent_2_0 disp_bicat_initial_obj.
Proof.
  use disp_subbicat_univalent_2_0.
  - exact univalent_cat_is_univalent_2.
  - intro C.
    apply isaprop_Initial.
    exact (pr2 C).
  - intros.
    apply isaprop_preserves_initial.
Qed.

Definition disp_univalent_2_disp_bicat_initial_obj
  : disp_univalent_2 disp_bicat_initial_obj.
Proof.
  split.
  - exact disp_univalent_2_0_disp_bicat_initial_obj.
  - exact disp_univalent_2_1_disp_bicat_initial_obj.
Defined.

Definition is_univalent_2_1_univ_cat_with_initial
  : is_univalent_2_1 univ_cat_with_initial.
Proof.
  use total_is_univalent_2_1.
  - exact univalent_cat_is_univalent_2_1.
  - exact disp_univalent_2_1_disp_bicat_initial_obj.
Defined.

Definition is_univalent_2_0_univ_cat_with_initial
  : is_univalent_2_0 univ_cat_with_initial.
Proof.
  use total_is_univalent_2_0.
  - exact univalent_cat_is_univalent_2_0.
  - exact disp_univalent_2_0_disp_bicat_initial_obj.
Defined.

Definition is_univalent_2_univ_cat_with_initial
  : is_univalent_2 univ_cat_with_initial.
Proof.
  split.
  - exact is_univalent_2_0_univ_cat_with_initial.
  - exact is_univalent_2_1_univ_cat_with_initial.
Defined.

(**
 6. Categories with binary coproducts
 *)
Definition disp_bicat_bincoprod
  : disp_bicat bicat_of_univ_cats.
Proof.
  use disp_subbicat.
  - exact (λ C, BinCoproducts (pr1 C)).
  - exact (λ C₁ C₂ _ _ F, preserves_bincoproduct F).
  - exact (λ C _, identity_preserves_bincoproduct _).
  - exact (λ _ _ _ _ _ _ _ _ HF HG, composition_preserves_bincoproduct HF HG).
Defined.

Definition univ_cat_with_bincoprod
  : bicat
  := total_bicat disp_bicat_bincoprod.

Definition disp_univalent_2_1_disp_bicat_bincoprod
  : disp_univalent_2_1 disp_bicat_bincoprod.
Proof.
  use disp_subbicat_univalent_2_1.
  intros.
  apply isaprop_preserves_bincoproduct.
Qed.

Definition disp_univalent_2_0_disp_bicat_bincoprod
  : disp_univalent_2_0 disp_bicat_bincoprod.
Proof.
  use disp_subbicat_univalent_2_0.
  - exact univalent_cat_is_univalent_2.
  - intro C.
    repeat (use impred ; intro).
    apply isaprop_BinCoproduct.
    exact (pr2 C).
  - intros.
    apply isaprop_preserves_bincoproduct.
Defined.

Definition disp_univalent_2_disp_bicat_bincoprod
  : disp_univalent_2 disp_bicat_bincoprod.
Proof.
  split.
  - exact disp_univalent_2_0_disp_bicat_bincoprod.
  - exact disp_univalent_2_1_disp_bicat_bincoprod.
Defined.

Definition is_univalent_2_1_univ_cat_with_bincoprod
  : is_univalent_2_1 univ_cat_with_bincoprod.
Proof.
  use total_is_univalent_2_1.
  - exact univalent_cat_is_univalent_2_1.
  - exact disp_univalent_2_1_disp_bicat_bincoprod.
Defined.

Definition is_univalent_2_0_univ_cat_with_bincoprod
  : is_univalent_2_0 univ_cat_with_bincoprod.
Proof.
  use total_is_univalent_2_0.
  - exact univalent_cat_is_univalent_2_0.
  - exact disp_univalent_2_0_disp_bicat_bincoprod.
Defined.

Definition is_univalent_2_univ_cat_with_bincoprod
  : is_univalent_2 univ_cat_with_bincoprod.
Proof.
  split.
  - exact is_univalent_2_0_univ_cat_with_bincoprod.
  - exact is_univalent_2_1_univ_cat_with_bincoprod.
Defined.
