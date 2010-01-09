open OUnit
open Poly

let assert_equal_float = assert_equal ~cmp:cmp_float ~printer:string_of_float

let random_poly n = 
  make (Array.init (n+1) (fun _ -> Random.float 1.0 -. 0.5))

let randomized_test_binary_op op pop = 
  for i = 1 to 100 do 
    let n1 = 1 + (Random.int 5) and 
        n2 = 1 + (Random.int 5) in 
    let p1 = random_poly n1 and 
        p2 = random_poly n2 in 
    let p = pop p1 p2 in 
      for i = 1 to 100 do 
        let x = Random.float 1.0 -. 0.5 in 
        let y1 = eval p1 x and 
            y2 = eval p2 x and 
            y = eval p x in 
          assert_equal_float (op y1 y2) y
      done
  done

let test_deriv () = 
  for i = 1 to 100 do 
    let n = 1 + (Random.int 5) in 
    let p = random_poly n in 
    let x = Random.float 1.0 -. 0.5 and 
        dx = sqrt (epsilon_float) in 
    let dy = (eval p (x +. dx)) -. (eval p x) in 
    let d_num = dy /. dx and 
        d = eval (deriv p) x in 
      assert_equal ~cmp:(cmp_float ~epsabs:1e-3 ~epsrel:1e-3) ~printer:string_of_float d d_num
  done

let tests = "poly.ml tests" >:::
  ["randomized add test" >:: (fun () -> randomized_test_binary_op (+.) add);
   "randomize sub test" >:: (fun () -> randomized_test_binary_op (-.) sub);
   "randomize mul test" >:: (fun () -> randomized_test_binary_op ( *. ) mul);
   "deriv test" >:: test_deriv]
