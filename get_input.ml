
open Printf
(*random comment*)
let file = "diff.txt"

let check_line line =
  match line.[0] with
  |'+' -> line
  | _ -> ""
  ;;
(*hullo*)

let () = (*entry point*)
  let ic = open_in file in
  try
    while true do
      (* 
       * `in` is a more readable way of writing multiple function calls
       * the code below could've been written as `printf (input_line ic)`
       * but as the number of function calls grow this approach can become
       * hard to read so in is preferred to store the output of a function call
       * and later use it in another context.
      *)
      let line = check_line (input_line ic) in   (*in required when there is a follow up line*)
      printf "%s\n\n" line
    done
  with 
    End_of_file -> close_in ic