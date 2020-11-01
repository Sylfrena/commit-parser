open Printf
open Str
let syname: string = "@@ -253 +253 @@ static int rtl8180_wx_get_range(struct net_device *dev,"

(*Read file contents*)
let read_whole_file filename =
  let ch = open_in filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s
let rec print_list (l: Str.split_result list) (t: int) =
  match l, t with
  | [], _ -> ()
  | Text hd :: tl, _ ->  print_list tl t 
  | Delim hd :: tl, 1 -> print_string (Str.replace_first (Str.regexp "+++ b/") "" hd) ; print_string "\n" ; print_list tl t
  | Delim hd :: tl, 0 -> print_string (Str.replace_first (Str.regexp "+") "" hd) ; print_string "\n" ; print_list tl t
  | Delim hd :: tl, _ -> print_string hd ; print_string "\n" ; print_list tl t
;;
let bash_read_help fpath =
  let command = "cd " ^ fpath ^ " && git diff | egrep '^+++|^@'" in
  let ic = Unix.open_process_in command in 
  let all_input = ref [] in 
  try
    while true do
      all_input := input_line ic :: !all_input
    done;
    !all_input
  with
    End_of_file -> close_in ic;
    List.rev !all_input;;


let fetch_file_name lines = 
  let pat_filename = Str.regexp "\\(+++ b\\)/\\(.+\\)\\.[a-z]" in
  (*let diff = String.concat "\n" lines  in *)
  let s = Str.full_split pat_filename lines in
  s;;
  
let fetch_line_number lines  = 
  let pat_linnum = Str.regexp "\\(\\+\\([0-9]+,[0-9]+\\)\\)" in
  (*let diff = String.concat "\n" lines in*)
  let s = Str.full_split pat_linnum lines in
  s;;

(*let rec parse_line_number (l: Str.split_result list) =
  match l with
  | [] -> ()
  | hd :: tl -> print_split_res hd ; print_string "\n" ; print_list tl
;;*)


type diff_info = 
{   
    file_name: Str.split_result list; 
    additions: int;
    line_no: (int * int) list;
}


(*let sample1 : diff_info = {fetch_file_name g; fetch_line_number }
*)

(*check line and extract file name or file number*)
let extract_names line = 
  let line_first = String.sub line 0 1 in
  match line_first with
  | "+" -> print_list (fetch_file_name line) 1
  | "@" -> print_list (fetch_line_number line) 0
  | _ ->  ()
;;


let () =
  let lines = bash_read_help "~/Elantris/snowflower/commit-parser" in
  List.iter extract_names lines
;; 
  (*
  +++ b/get_input.m
  +1,6
  +++ b/just_print.m
  +15,8
  +30,14
  +53,39
  
  print_list (fetch_file_name lines);
  print_list (fetch_line_number lines);*)



(*let diff = read_whole_file "diff.txt"
let diff2 = read_whole_file "diff2.txt"
let d = Str.replace_first (Str.regexp "a/") "" *)