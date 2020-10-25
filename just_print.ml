open Printf
open Str
let syname: string = "@@ -253 +253 @@ static int rtl8180_wx_get_range(struct net_device *dev,"

(*Read file contents*)
let read_whole_file filename =
  let ch = open_in filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
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
let bash_read_help  =
  let ic = Unix.open_process_in "cd ~/Elantris/v4l-utils && git diff" in 
  let all_input = ref [] in 
  try
    while true do
      all_input := input_line ic :: !all_input
    done;
    !all_input
  with
    End_of_file -> close_in ic;
    List.rev !all_input;;

let fileb in_str = 
  let pat_filename = Str.regexp "\\(+++ b\\)/\\(.+\\)\\.[a-z]" in
  let s = Str.full_split pat_filename in_str in
  s;;
  
let line_numb in_str = 
  let pat_linnum = Str.regexp "\\(\\+\\([0-9]+,[0-9]+\\)\\)" in
  let s = Str.full_split pat_linnum in_str in
  s;;

 

    
let g = String.concat "" bash_read_help
let diff = read_whole_file "diff.txt"
let diff2 = read_whole_file "diff2.txt"

(*Str.replace_first (Str.regexp "a/") ""*)



(*print_list linnum*)(*List.iter(printf "%shi***") fileb*)
let () = print_list fileb;