open Hardcaml
open Signal

module Adder = struct
  let create a b =
    a +: b
end

module Modulo = struct
  let create x =
    x %:. 100
end

module Normalize = struct
  let create x =
    mux2 (x <:. 0) (x +:. 100) x
end

module Comparator = struct
  let create x =
    x ==:. 0
end

module Counter = struct
  let create ~clk ~rst ~inc =
    let spec = Reg_spec.create ~clock:clk ~reset:rst () in
    reg spec ~enable:inc (zero 32)
end

module Top = struct
  module I = struct
    type 'a t =
      { clk : 'a
      ; rst : 'a
      ; valid : 'a
      ; dir : 'a
      ; n : 'a
      }
    [@@deriving hardcaml]
  end

  module O = struct
    type 'a t =
      { zeroCount : 'a
      ; xOut : 'a
      }
    [@@deriving hardcaml]
  end

  let create (i : _ I.t) =
    let spec = Reg_spec.create ~clock:i.clk ~reset:i.rst () in

    let signedn =
      mux2 i.dir i.n (neg i.n)
    in

    let xreg =
      reg spec ~enable:i.valid (of_int ~width:32 50)
    in

    let addout =
      Adder.create xreg signedn
    in

    let modout =
      Modulo.create addout
    in

    let normout =
      Normalize.create modout
    in

    let zerohit =
      Comparator.create normout
    in

    let x_next =
      normout
    in

    let xreg =
      reg spec ~enable:i.valid ~reset_to:(of_int ~width:32 50) x_next
    in

    let zerocount =
      Counter.create
        ~clk:i.clk
        ~rst:i.rst
        ~inc:(i.valid &: zerohit)
    in

    { O.zeroCount = zerocount
    ; xOut = xreg
    }
end
