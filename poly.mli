(** Evaluate and manipulate polynomials via their coefficients.  The
    convention is that the [i]th element of a coefficient array, [p],
    is the coefficient of x^[i]. *)

(** Polynomials *)
type poly

(** Construct a poly given the coefficients. *)
val make : float array -> poly

(** Extract the coefficients from a poly. *)
val coeffs : poly -> float array

(** The order of the polynomial. *)
val order : poly -> int

(** Add two polynomials. *)
val add : poly -> poly -> poly

(** Subtract two polynomials. *)
val sub : poly -> poly -> poly

(** Multiply two polynomials. *)
val mul : poly -> poly -> poly

(** Compute the polynomial that is the derivative of the given poly. *)
val deriv : poly -> poly

(** [eval poly x] evaluates [poly] at the point [x]. *)
val eval : poly -> float -> float

(** [from_roots roots] produces a polynomial that (up to roundoff
    error, which can be {b significant} for some unfortunate
    polynomials) has the given (real) roots. *)
val from_roots : float array -> poly
