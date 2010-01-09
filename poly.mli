(*  poly.mli: Interface file for code to manipulate polynomials. 
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
