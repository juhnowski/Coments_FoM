Require Import Classical.

Section LogicEquivalence.
  Variables p q : Prop.

  (* Лемма: ~(~p \/ ~q) → p *)
  Lemma not_or_not_implies_p : ~(~p \/ ~q) → p.
  Proof.
    intros H.
    apply (fun Hnp : ~p => False).
    apply H.
    left.
    assumption.
  Qed.

  (* Лемма: ~(~p \/ ~q) → q *)
  Lemma not_or_not_implies_q : ~(~p \/ ~q) → q.
  Proof.
    intros H.
    apply (fun Hnq : ~q => False).
    apply H.
    right.
    assumption.
  Qed.

  (* Теорема: p /\ q эквивалентно ~(~p \/ ~q) *)
  Theorem conj_equiv_not_disj : p /\ q <-> ~(~p \/ ~q).
  Proof.
    split.

    (* Доказываем: p /\ q → ~(~p \/ ~q) *)
    intros H.
    intros Contr.
    destruct H as [Hp Hq].
    destruct Contr as [Hnp | Hnq].
    - apply Hnp in Hp. contradiction.
    - apply Hnq in Hq. contradiction.

    (* Доказываем: ~(~p \/ ~q) → p /\ q *)
    intros H.
    split.
    - apply not_or_not_implies_p. assumption.
    - apply not_or_not_implies_q. assumption.
  Qed.
End LogicEquivalence.
