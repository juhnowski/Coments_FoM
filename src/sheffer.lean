-- Определение штриха Шеффера (NAND)
def nand (a b : Prop) : Prop := ¬ (a ∧ b)

-- Теорема: \( p \rightarrow q \) эквивалентно \( \text{nand } p (\text{nand } q q) \)
theorem sheffer_implication (p q : Prop) :
  (p → q) ↔ (nand p (nand q q)) := by
  constructor
  -- Доказываем направление: \( p \rightarrow q \) влечёт \( \text{nand } p (\text{nand } q q) \)
  { intro h
    unfold nand
    intro contra
    -- contra — это \( p \land (\text{nand } q q) \)
    cases contra with p_true nand_q_q
    -- Разворачиваем \( \text{nand } q q \)
    unfold nand at nand_q_q
    -- \( \text{nand } q q \) — это \( ¬ (q \land q) \), что эквивалентно \( ¬ q \)
    have q_false : ¬ q := by
      intro q_true
      apply nand_q_q
      constructor
      exact q_true
      exact q_true
    -- Теперь у нас есть \( p \) и \( ¬ q \)
    -- Но \( h \) — это \( p \rightarrow q \), поэтому \( p \) и \( ¬ q \) приводят к противоречию
    apply q_false
    apply h
    exact p_true }
  -- Доказываем обратное направление: \( \text{nand } p (\text{nand } q q) \) влечёт \( p \rightarrow q \)
  { intro h_nand
    unfold nand at h_nand
    intro p_true
    intro q_false
    -- Если \( q \) ложно, то \( \text{nand } q q \) истинно
    have nand_q_q : nand q q := by
      unfold nand
      intro q_and_q
      cases q_and_q with q1 q2
      exact q_false q1
    -- Теперь у нас есть \( p \) и \( \text{nand } q q \)
    -- Но \( h_nand \) — это \( ¬ (p \land \text{nand } q q) \)
    have p_and_nand : p ∧ nand q q := by
      constructor
      exact p_true
      exact nand_q_q
    -- Это противоречит \( h_nand \)
    exact h_nand p_and_nand }
