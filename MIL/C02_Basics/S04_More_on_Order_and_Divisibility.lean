import MIL.Common
import Mathlib.Data.Real.Basic

namespace C02S04

section
variable (a b c d : ℝ)

#check (min_le_left a b : min a b ≤ a)
#check (min_le_right a b : min a b ≤ b)
#check (le_min : c ≤ a → c ≤ b → c ≤ min a b)

example : min a b = min b a := by
  apply le_antisymm
  · show min a b ≤ min b a
    apply le_min
    · apply min_le_right
    apply min_le_left
  · show min b a ≤ min a b
    apply le_min
    · apply min_le_right
    apply min_le_left

example : min a b = min b a := by
  have h : ∀ x y : ℝ, min x y ≤ min y x := by
    intro x y
    apply le_min
    apply min_le_right
    apply min_le_left
  apply le_antisymm
  apply h
  apply h

example : min a b = min b a := by
  apply le_antisymm
  repeat
    apply le_min
    apply min_le_right
    apply min_le_left

example : max a b = max b a := by
  apply le_antisymm
  repeat
    apply max_le
    apply le_max_right
    apply le_max_left

example : min (min a b) c = min a (min b c) := by
  apply le_antisymm
  · apply le_min
    · apply le_trans
      apply min_le_left
      apply min_le_left
    apply le_min
    · apply le_trans
      apply min_le_left
      apply min_le_right
    apply min_le_right
  apply le_min
  · apply le_min
    · apply min_le_left
    apply le_trans
    apply min_le_right
    apply min_le_left
  apply le_trans
  apply min_le_right
  apply min_le_right

example : max (max a b) c = max a (max b c) := by
  apply le_antisymm
  · apply max_le
    · apply max_le
      · apply le_max_left
      · have h3 : ∀ x y : ℝ, x ≤ max x y := by
          apply le_max_left
        have h4: ∀ x y z : ℝ, y ≤ max x (max y z) := by
          exact fun x y z ↦ le_max_of_le_right (h3 y z)
        exact h4 a b c
    · have h1 : ∀ x y : ℝ, y ≤ max x y := by
        apply le_max_right
      have h2: ∀ x y z : ℝ, y ≤ max z (max x y) := by
        exact fun x y z ↦ le_max_of_le_right (h1 x y)
      exact h2 b c a
  · apply max_le
    · have h5: ∀ x y : ℝ, x ≤ max x y := by
        apply le_max_left
      have h6: ∀ x y z : ℝ, x ≤ max (max x y) z := by
        exact fun x y z ↦ le_max_of_le_left (h5 x y)
      exact h6 a b c
    · apply max_le
      · have h7: ∀ x y : ℝ,  y ≤ max x y := by
          apply le_max_right
        have h8: ∀ x y z : ℝ, y ≤ max (max x y) z := by
          exact fun x y z ↦ le_max_of_le_left (h7 x y)
        exact h8 a b c
      · apply le_max_right

theorem aux : min a b + c ≤ min (a + c) (b + c) := by
  apply le_min
  · apply add_le_add_right
    apply min_le_left
  · apply add_le_add_right
    apply min_le_right

example : min a b + c = min (a + c) (b + c) := by
  apply le_antisymm
  · apply aux
  · have h : min (a + c) (b + c) = min (a + c) (b + c) - c + c := by
      rw [sub_add_cancel]
    rw [h]
    apply add_le_add_right
    rw [sub_eq_add_neg]
    apply le_trans
    apply aux
    rw [add_neg_cancel_right]
    rw [add_neg_cancel_right]

#check (abs_add : ∀ a b : ℝ, |a + b| ≤ |a| + |b|)

example : |a| - |b| ≤ |a - b| := by
  have h := abs_add (a - b) b
  rw [sub_add_cancel] at h
  linarith

end

section
variable (w x y z : ℕ)

example (h₀ : x ∣ y) (h₁ : y ∣ z) : x ∣ z :=
  dvd_trans h₀ h₁

example : x ∣ y * x * z := by
  apply dvd_mul_of_dvd_left
  apply dvd_mul_left

example : x ∣ x ^ 2 := by
  apply dvd_mul_left

example (h : x ∣ w) : x ∣ y * (x * z) + x ^ 2 + w ^ 2 := by
  have h1 : x ∣ y * (x * z) := by
    rw [← mul_assoc]
    apply dvd_mul_of_dvd_left
    apply dvd_mul_left
  have h2 : x ∣ x^2 := by
    rw [pow_two]
    apply dvd_mul_left
  have h3 : x ∣ w^2 := by
    rw [pow_two]
    apply dvd_mul_of_dvd_left h
  apply dvd_add
  apply dvd_add
  apply h1
  apply h2
  apply h3
end

section
variable (m n : ℕ)

#check (Nat.gcd_zero_right n : Nat.gcd n 0 = n)
#check (Nat.gcd_zero_left n : Nat.gcd 0 n = n)
#check (Nat.lcm_zero_right n : Nat.lcm n 0 = 0)
#check (Nat.lcm_zero_left n : Nat.lcm 0 n = 0)

example : Nat.gcd m n = Nat.gcd n m := by
  apply Nat.dvd_antisymm
  · apply Nat.dvd_gcd
    · apply Nat.gcd_dvd_right
    · apply Nat.gcd_dvd_left
  · apply Nat.dvd_gcd
    · apply Nat.gcd_dvd_right
    · apply Nat.gcd_dvd_left
end
