open Printf
open Arg


(* Input commit id to be checked by Coccinelle
 * TODO : Fetch commit and diff *)
let commit_id = ref "."

let set_commit_id input_id = 
  commit_id := input_id 

let () = 
begin
  let speclist = [("-c", Arg.String(set_commit_id), "flag to specify commit id");] in
  let usage_msg = "Usage: ./ic [OPTION] [COMMIT ID]" in
  Arg.parse speclist print_endline usage_msg;
  printf "Commit Id: %s" !commit_id;
end




