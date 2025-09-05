Require Import Coq.Logic.FunctionalExtensionality.
Require Import Coq.Arith.Arith.
Require Import Coq.Bool.Bool.

(* Определение логических операций *)
Definition andb (a b : bool) : bool :=
  match a, b with
  | true, true => true
  | _, _ => false
  end.

Definition orb (a b : bool) : bool :=
  match a, b with
  | false, false => false
  | _, _ => true
  end.

Definition notb (a : bool) : bool :=
  match a with
  | true => false
  | false => true
  end.

(* Определение импликации *)
Definition implb (a b : bool) : bool :=
  orb (notb a) b.

(* Определение штриха Шеффера *)
Definition nandb (a b : bool) : bool :=
  notb (andb a b).

(* Теорема: \( p \rightarrow q \) эквивалентно \( p \mid (q \mid q) \) *)
Theorem sheffer_implication :
  forall p q : bool,
    implb p q = nandb p (nandb q q).
Proof.
  intros p q.
  unfold implb, nandb, andb, orb, notb.
  destruct p; destruct q; simpl.
  - (* p = false, q = false *)
    reflexivity.
  - (* p = false, q = true *)
    reflexivity.
  - (* p = true, q = false *)
    reflexivity.
  - (* p = true, q = true *)
    reflexivity.
Qed.
