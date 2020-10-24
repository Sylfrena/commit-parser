open Printf
open Str
let syname: string = "@@ -253 +253 @@ static int rtl8180_wx_get_range(struct net_device *dev,"

let read_whole_file filename =
  let ch = open_in filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s

let diff = read_whole_file "diff.txt"
let diff2 = read_whole_file "diff2.txt"

(*Str.replace_first (Str.regexp "a/") ""*)
let fileb = 
  let pat_filename = Str.regexp "\\(+++ b\\)/\\(.+\\)\\.[a-z]" in
  let s = Str.full_split pat_filename diff in
  s

let linnum = 
  let pat_linnum = Str.regexp "\\(\\+\\([0-9]+,[0-9]+\\)\\)" in
  let s = Str.full_split pat_linnum diff2 in
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

() = print_list linnum
(*List.iter(printf "%shi***") fileb*)

