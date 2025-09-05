module Main where

{-# LANGUAGE ScopedTypeVariables #-}

import Test.LeanCheck

-- Оператор штриха Шеффера
infixl 4 |>
(|>) :: Bool -> Bool -> Bool
a |> b = not (a && b)

-- Исходное выражение: (((p |> q) |> r) |> s)
originalExpression :: Bool -> Bool -> Bool -> Bool -> Bool
originalExpression p q r s = ((p |> q) |> r) |> s

-- Правая часть: (not p) || (q && r) || (not s)
rightExpression :: Bool -> Bool -> Bool -> Bool -> Bool
rightExpression p q r s = (not p) || (q && r) || (not s)

-- Свойство: обе функции должны возвращать одинаковые результаты
prop_equivalent :: Bool -> Bool -> Bool -> Bool -> Bool
prop_equivalent p q r s = originalExpression p q r s == rightExpression p q r s

-- Проверка свойства
main :: IO ()
main = do
  putStrLn "Проверка эквивалентности выражений с использованием LeanCheck:"
  check prop_equivalent
