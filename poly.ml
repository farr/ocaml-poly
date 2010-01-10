(*  poly.ml: Code for manipulating polynomials.
    Copyright (C) 2010 Will M. Farr <wmfarr@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>. *)

type poly = float array

let order (p : poly) = Array.length p - 1

let add p1 p2 = 
  let n1 = Array.length p1 and 
      n2 = Array.length p2 in 
  let n = max n1 n2 in 
  let res = Array.make n 0.0 in 
    for i = 0 to (min n1 n2) - 1 do 
      res.(i) <- p1.(i) +. p2.(i)
    done;
    let maxp = if n1 > n2 then p1 else p2 in 
      for i = (min n1 n2) to n - 1 do 
        res.(i) <- maxp.(i)
      done;
      res

let sub p1 p2 = 
  let n1 = Array.length p1 and 
      n2 = Array.length p2 in 
  let n = max n1 n2 in 
  let res = Array.make n 0.0 in 
    for i = 0 to (min n1 n2) - 1 do 
      res.(i) <- p1.(i) -. p2.(i)
    done;
    let maxp = if n1 > n2 then p1 else p2 and 
        sign = if n1 > n2 then 1.0 else -1.0 in 
      for i = (min n1 n2) to n - 1 do 
        res.(i) <- sign*.maxp.(i)
      done;
      res

let mul p1 p2 = 
  let n1 = Array.length p1 and 
      n2 = Array.length p2 in 
  let n = n1 + n2 - 1 in 
  let res = Array.make n 0.0 in 
    for i = 0 to n1 - 1 do 
      for j = 0 to n2 - 1 do 
        res.(i+j) <- res.(i+j) +. p1.(i)*.p2.(j)
      done
    done;
    res

let deriv p = 
  let n = Array.length p in 
    if n = 1 then 
      Array.make 1 0.0
    else
      let res = Array.make (n-1) 0.0 in 
        for i = 1 to n - 1 do 
          res.(i-1) <- (float_of_int i)*.p.(i)
        done;
        res

let eval p x = 
  let n = Array.length p in 
  let res = ref p.(n-1) in 
    for i = n - 2 downto 0 do 
      res := !res*.x +. p.(i)
    done;
    !res

let make (p : poly) = Array.copy p
let coeffs (p : poly) = Array.copy p

let from_roots roots = 
  Array.fold_left
    (fun p root -> 
       mul p [| ~-.root; 1.0|])
    [|1.0|]
    roots
