open Printf
open Str
let syname: string = "diff --git a/drivers/usc/filex.c b/drivers/usc/filex"

let fileb = 
  let pat_filename = Str.regexp "a/\\(.+\\)" in
  let s = Str.full_split pat_filename syname in
  s

let print_split_res (elem: Str.split_result) =
  match elem with
  | Text t -> ()
  | Delim d -> print_string d

let rec print_list (l: Str.split_result list) =
  match l with
  | [] -> ()
  | hd :: tl -> print_split_res hd ; print_string "\n" ; print_list tl
;;

() = print_list fileb
(*List.iter(printf "%shi***") fileb*)