open Hardcaml
open Signal

module Mux2 = struct
  let create a b sel =
    mux2 sel b a
end

module Absval = struct
  let create a =
    mux2 (a <:. 0) (neg a) a
end

module Iszero = struct
  let create a =
    a ==:. 0
end

module Gthundred = struct
  let create a =
    a >:. 100
end

module Ltzero = struct
  let create a =
    a <:. 0
end

module Top = struct
  module I = struct
    type 'a t =
      { clk : 'a
      ; reset : 'a
      ; n : 'a
      }
    [@@deriving hardcaml]
  end

  module O = struct
    type 'a t =
      { c : 'a }
    [@@deriving hardcaml]
  end

  let create (i : _ I.t) =
    let spec = Reg_spec.create ~clock:i.clk ~reset:i.reset () in

    let x = reg spec (of_int ~width:32 50) in
    let c = reg spec (zero 32) in

    let absn = Absval.create i.n in
    let n1 = absn /:. 100 in
    let n2 = absn %:. 100 in
    let dir = not_bit (i.n.[31]) in
    let dirval = mux2 dir (of_int ~width:32 1) (of_int ~width:32 (-1)) in

    let zerox = Iszero.create x in
    let zeroval = mux2 dir n2 (of_int ~width:32 100 - n2) in
    let moveval = x +: dirval *: n2 in
    let xnext = Mux2.create moveval zeroval zerox in

    let gth = Gthundred.create xnext in
    let ltz = Ltzero.create xnext in
    let crossed = (~:zerox) &: (gth |: ltz) in
    let xmod = ((xnext %:. 100) +:. 100) %:. 100 in

    always spec (fun () ->
      x <== xmod;
      c <== c +: n1 +: mux2 crossed (of_int 1) (of_int 0) +: mux2 (xmod ==:. 0) (of_int 1) (of_int 0)
    );

    { O.c = c }
end

let () =
  let module C = Circuit.With_interface (Top.I) (Top.O) in
  let circuit = C.create ~name:"part1" Top.create in
  Rtl.output Verilog circuit