Require Import UniMath.Foundations.All.
Require Import UniMath.MoreFoundations.All.

Require Import UniMath.CategoryTheory.Core.Categories.
Require Import UniMath.CategoryTheory.Core.Functors.
Require Import UniMath.CategoryTheory.Core.NaturalTransformations.
Require Import UniMath.CategoryTheory.Core.Isos.

Require Import UniMath.CategoryTheory.PrecategoryBinProduct.
Require Import UniMath.CategoryTheory.FunctorCategory.

Require Import UniMath.CategoryTheory.DisplayedCats.Core.
Require Import UniMath.CategoryTheory.DisplayedCats.Total.
Require Import UniMath.CategoryTheory.DisplayedCats.Constructions.

Require Import UniMath.CategoryTheory.Monoidal.MonoidalCategories.

Local Open Scope cat.

Local Notation "C ⊠ D" := (category_binproduct C D) (at level 38).

Local Notation "( c , d )" := (make_catbinprod c d).
Local Notation "( f #, g )" := (catbinprodmor f g).

Section TensorFunctorCategory.

  Context {C D : category}
          (TC : functor (C ⊠ C) C)
          (TD : functor (D ⊠ D) D).

  Notation "X ⊗_C Y" := (TC (X , Y)) (at level 31).
  Notation "f #⊗_C g" := (# TC (f #, g)) (at level 31).
  Notation "X ⊗_D Y" := (TD (X , Y)) (at level 31).
  Notation "f #⊗_D g" := (# TD (f #, g)) (at level 31).

  Definition functor_tensor_map_dom (F : functor C D)
    : functor (C ⊠ C) D
    := functor_composite (pair_functor F F) TD.

  Definition functor_tensor_map_codom (F : functor C D)
    : functor (C ⊠ C) D
    := functor_composite TC F.

  Definition functor_tensor (F : functor C D)
    : UU := nat_trans (functor_tensor_map_dom F) (functor_tensor_map_codom F).
  Identity Coercion functor_tensor_c : functor_tensor >-> nat_trans.

  Definition nat_trans_tensor {F G : functor C D}
             (FF : functor_tensor F) (GG : functor_tensor G)
             (α : nat_trans F G) : UU
    := ∏ x y : C, (α x #⊗_D α y) · GG (x, y)
                  = FF (x, y) · α (x ⊗_C y).

  Lemma isaprop_nat_trans_tensor {F G : functor C D}
             (FF : functor_tensor F) (GG : functor_tensor G)
             (α : nat_trans F G)
    : isaprop (nat_trans_tensor FF GG α).
  Proof.
    do 2 (apply impred_isaprop ; intro) ; apply homset_property.
  Qed.

  Definition nat_trans_tensor_id
             {F : functor C D} (FF : functor_tensor F)
    : nat_trans_tensor FF FF (nat_trans_id F).
  Proof.
    intros x y.
    simpl.
    rewrite (functor_id TD).
    exact (id_left _ @ ! id_right _).
  Qed.

  Definition nat_trans_tensor_comp
             {F G H : functor C D}
             (FF : functor_tensor F) (GG : functor_tensor G) (HH : functor_tensor H)
             {α : nat_trans F G} {β : nat_trans G H}
             (αα : nat_trans_tensor FF GG α)
             (ββ : nat_trans_tensor GG HH β)
    : nat_trans_tensor FF HH (nat_trans_comp _ _ _ α β).
  Proof.
    intros x y.
    simpl.
    etrans. {
      apply maponpaths_2.
      exact (functor_comp TD (α x #, α y) (β x #, β y)).
    }
    rewrite assoc'.
    etrans. {
      apply maponpaths.
      exact (ββ x y).
    }
    do 2 rewrite assoc.
    apply maponpaths_2.
    apply αα.
  Qed.

  Definition functor_tensor_disp_cat_ob_mor
    : disp_cat_ob_mor [C,D].
  Proof.
    exists (λ F, functor_tensor F).
    exact (λ F G FF GG α, nat_trans_tensor FF GG α).
  Defined.

  Definition functor_tensor_disp_cat_id_comp
    : disp_cat_id_comp _ functor_tensor_disp_cat_ob_mor.
  Proof.
    split ; intro ; intros ; [apply nat_trans_tensor_id | use nat_trans_tensor_comp ; assumption ].
  Qed.

  Definition functor_tensor_disp_cat_data
    : disp_cat_data [C,D]
    := _ ,, functor_tensor_disp_cat_id_comp.

  Definition functor_tensor_disp_cat_axioms
    : disp_cat_axioms _ functor_tensor_disp_cat_data.
  Proof.
    repeat split ; intro ; intros ; try (apply isaprop_nat_trans_tensor).
    use isasetaprop.
    apply isaprop_nat_trans_tensor.
  Qed.

  Definition functor_tensor_disp_cat : disp_cat [C,D]
    := _ ,, functor_tensor_disp_cat_axioms.

  Definition functor_tensor_cat : category
    := total_category functor_tensor_disp_cat.

End TensorFunctorCategory.

Section TensorFunctorProperties.

  Lemma TODO_JOKER' (A : UU) : A. Proof. Admitted.
  Definition functor_tensor_composition
             {C D E : category}
             {TC : functor (C ⊠ C) C}
             {TD : functor (D ⊠ D) D}
             {TE : functor (E ⊠ E) E}
             {F : functor C D} {G : functor D E}
             (FF : functor_tensor TC TD F) (GG : functor_tensor TD TE G)
    : functor_tensor TC TE (functor_composite F G).
  Proof.
    exists (λ cc, GG (F (pr1 cc) , F (pr2 cc)) · #G (FF cc)).
    abstract (intros cc1 cc2 ff ; apply TODO_JOKER').
  Defined.

  (* A characterization of the tensor property of monoidal natural transformations
     in terms of equality/isos of functors/natural transformations. *)
  Context {C D E : category}
          {TC : functor (C ⊠ C) C}
          {TD : functor (D ⊠ D) D}.

  Notation "X ⊗_C Y" := (TC (X , Y)) (at level 31).
  Notation "f #⊗_C g" := (# TC (f #, g)) (at level 31).
  Notation "X ⊗_D Y" := (TD (X , Y)) (at level 31).
  Notation "f #⊗_D g" := (# TD (f #, g)) (at level 31).

  Context {F G : functor C D}
          (FF : functor_tensor TC TD F) (GG : functor_tensor TC TD G)
          (α : nat_trans F G).

  Lemma nat_trans_tensor_ntrans1_is_nat_trans
    :  is_nat_trans
         (functor_tensor_map_dom TD F)
         (functor_tensor_map_codom TC G)
         (λ cc : _, # TD (α (pr1 cc) #, α (pr2 cc)) · GG cc).
  Proof.
    intros cc1 cc2 ff.
    simpl.
    rewrite assoc.
    rewrite <- (functor_comp TD).
    rewrite <- binprod_comp.
    do 2 rewrite (pr2 α).
    rewrite binprod_comp.
    rewrite (functor_comp TD).
    do 2 rewrite assoc'.
    apply maponpaths.
    apply (pr2 GG).
  Qed.

  Definition nat_trans_tensor_ntrans1
    : nat_trans (functor_tensor_map_dom TD F) (functor_tensor_map_codom TC G)
    := _ ,, nat_trans_tensor_ntrans1_is_nat_trans.

  Definition nat_trans_tensor_ntrans2_is_nat_trans
    : is_nat_trans
        (functor_tensor_map_dom TD F)
        (functor_tensor_map_codom TC G)
        (λ cc : C ⊠ C, FF cc · α (pr1 cc ⊗_C pr2 cc)).
  Proof.
    intros cc1 cc2 ff.
    simpl.
    set (t := pr2 FF cc1 cc2).
    simpl in t.
    rewrite assoc.
    rewrite t.
    do 2 rewrite assoc'.
    apply maponpaths.
    apply (pr2 α).
  Qed.

  Definition nat_trans_tensor_ntrans2
    : nat_trans (functor_tensor_map_dom TD F) (functor_tensor_map_codom TC G)
    := _ ,, nat_trans_tensor_ntrans2_is_nat_trans.

  Definition nat_trans_tensor' : UU
    := nat_trans_tensor_ntrans1 = nat_trans_tensor_ntrans2.

  Lemma nat_trans_tensor_to_characterization
        (p : nat_trans_tensor')
    : nat_trans_tensor TC TD FF GG α.
  Proof.
    intros x y.
    exact (toforallpaths _ _ _ (base_paths _ _ p) (x,y)).
  Qed.

  Lemma nat_trans_tensor_from_characterization
        (p : nat_trans_tensor TC TD FF GG α)
    : nat_trans_tensor'.
  Proof.
    use nat_trans_eq.
    { apply homset_property. }
    exact (λ cc, p (pr1 cc) (pr2 cc)).
  Qed.

End TensorFunctorProperties.

Section UnitFunctorCategory.

  Context {C D : category} (IC : C) (ID : D).

  Definition functor_unit (F : functor C D) : UU
    := D⟦ID, pr1 F IC⟧.

  Definition nat_trans_unit
             {F G : functor C D} (FF : functor_unit F) (GG : functor_unit G)
             (α : nat_trans F G) : UU
    := FF · α IC = GG.

  Definition functor_unit_disp_cat_ob_mor
    : disp_cat_ob_mor [C,D].
  Proof.
    exists (λ F, functor_unit F).
    exact (λ F G FF GG α, nat_trans_unit FF GG α).
  Defined.

  Definition nat_trans_unit_id
             {F : functor C D} (FF : functor_unit F)
    : nat_trans_unit FF FF (nat_trans_id F).
  Proof.
    apply id_right.
  Qed.

  Definition nat_trans_unit_comp
             {F G H : functor C D}
             (FF : functor_unit F) (GG : functor_unit G) (HH : functor_unit H)
             {α : nat_trans F G} {β : nat_trans G H}
             (αα : nat_trans_unit FF GG α)
             (ββ : nat_trans_unit GG HH β)
    : nat_trans_unit FF HH (nat_trans_comp _ _ _ α β).
  Proof.
    etrans. { apply assoc. }
    etrans. { apply maponpaths_2 ; exact αα. }
    exact ββ.
  Qed.

  Definition functor_unit_disp_cat_id_comp
    : disp_cat_id_comp _ functor_unit_disp_cat_ob_mor.
  Proof.
    split ; intro ; intros ; [apply nat_trans_unit_id | use nat_trans_unit_comp ; assumption ].
  Qed.

  Definition functor_unit_disp_cat_data
    : disp_cat_data [C,D]
    := _ ,, functor_unit_disp_cat_id_comp.

  Definition functor_unit_disp_cat_axioms
    : disp_cat_axioms _ functor_unit_disp_cat_data.
  Proof.
    repeat split ; intro ; intros ; try (apply homset_property).
    use isasetaprop.
    apply homset_property.
  Qed.

  Definition functor_unit_disp_cat : disp_cat [C,D]
    := _ ,, functor_unit_disp_cat_axioms.

  Definition functor_unit_cat : category
    := total_category functor_unit_disp_cat.

End UnitFunctorCategory.

Local Definition functor_tensorunit_disp_cat
      {C D : category}
      (TC : functor (C ⊠ C) C) (TD : functor (D ⊠ D) D)
      (IC : C) (ID : D)
  : disp_cat [C,D]
  := dirprod_disp_cat (functor_tensor_disp_cat TC TD) (functor_unit_disp_cat IC ID).

Local Definition functor_tensorunit_cat {C D : category}
      (TC : functor (C ⊠ C) C) (TD : functor (D ⊠ D) D)
      (IC : C) (ID : D)
  : category
  := total_category (functor_tensorunit_disp_cat TC TD IC ID).

Section MonoidalFunctorCategory.

  Context {C D : category}
          {TC : functor (C ⊠ C) C} {TD : functor (D ⊠ D) D}
          {IC : C} {ID : D}
          (luC : left_unitor TC IC) (luD : left_unitor TD ID)
          (ruC : right_unitor TC IC) (ruD : right_unitor TD ID)
          (αC : associator TC) (αD : associator TD).

  Notation "X ⊗_C Y" := (TC (X , Y)) (at level 31).
  Notation "f #⊗_C g" := (# TC (f #, g)) (at level 31).
  Notation "X ⊗_D Y" := (TD (X , Y)) (at level 31).
  Notation "f #⊗_D g" := (# TD (f #, g)) (at level 31).

  Definition functor_lu_disp_cat : disp_cat (functor_tensorunit_cat TC TD IC ID).
  Proof.
    use disp_full_sub.
    intros [F [FT FU]].
    exact (∏ x : C, luD (pr1 F x) = FU #⊗_D (id (pr1 F x)) · (pr1 FT) (IC, x) · #(pr1 F) (luC x)).
  Defined.

  Definition functor_ru_disp_cat : disp_cat (functor_tensorunit_cat TC TD IC ID).
  Proof.
    use disp_full_sub.
    intros [F [FT FU]].
    exact (∏ x : C, ruD (pr1 F x) =  (id (pr1 F x)) #⊗_D FU · (pr1 FT) (x, IC) · #(pr1 F) (ruC x)).
  Defined.

  Definition functor_ass_disp_cat : disp_cat (functor_tensorunit_cat TC TD IC ID).
  Proof.
    use disp_full_sub.
    intros [F [FT FU]].

    exact (∏ (x y z : C),
            pr1 FT (x, y) #⊗_D id (pr1 F(z)) · pr1 FT (x ⊗_C y, z) · #(pr1 F) (αC ((x, y), z))
            =
              αD ((pr1 F x, pr1 F y), pr1 F z) · id (pr1 F x) #⊗_D pr1 FT (y, z) · pr1 FT (x, y ⊗_C z)).
  Defined.

  Definition functor_monoidal_disp_cat
    : disp_cat (functor_tensorunit_cat TC TD IC ID)
    := dirprod_disp_cat
         (dirprod_disp_cat functor_lu_disp_cat functor_ru_disp_cat)
         functor_ass_disp_cat.

  Definition functor_monoidal_cat
    : category
    := total_category functor_monoidal_disp_cat.

End MonoidalFunctorCategory.
