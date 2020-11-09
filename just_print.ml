open Printf
open Str
let syname: string = "@@ -253 +253 @@ static int rtl8180_wx_get_range(struct net_device *dev,"

(*Read file contents*)
let read_whole_file filename =
  let ch = open_in filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s

(*Breakdown split_result_list type to primtive type*)
  let rec print_list (l: Str.split_result list)  =
  match l with
  | [] -> []
  | Text hd :: tl ->  print_list tl  
  | Delim hd :: tl -> hd ::  print_list tl 
;;

(*Fetch diff for specified path*)
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

let extract_numbers line =
  let sep = String.split_on_char ',' line in
  match sep with
  | [l] -> (l, l)
  | [f ; e] -> (f, e)
  | _ -> failwith "no line"
  (*let arr = Array.of_list sep in
  let arr_i = Array.map int_of_string arr in
  arr_i.(1) =  arr_i.(0) + arr_i.(1) - 1*)
;;
let fetch_file_name lines = 
  let pat_filename = Str.regexp "\\(+++ b\\)/\\(.+\\)\\.[a-z]+" in
  (*let diff = String.concat "\n" lines  in *)
  let s = Str.full_split pat_filename lines in
  print_list s
;;
  
let fetch_line_number lines  = 
  let pat_linnum = Str.regexp "\\(\\+\\([0-9]+,[0-9]+\\)\\)" in
  (*let diff = String.concat "\n" lines in*)
  let s = Str.full_split pat_linnum lines in
  let faa = print_list s in
  List.map 
    (function fa ->  
        let (b, e) = extract_numbers fa in 
        (b, e)) 
    faa 
;;


type diff_info = 
{   
    file_name: string; 
    line_no: (int * int) list;
}

type patch_i = No_info | File_info of string list | Line_info of (string * string) list 


(* let  

*)
(*let sample1 : diff_info = {fetch_file_name g; fetch_line_number }
*)

(*check line and extract file name or file number*)
let extract_info line =
  if Str.string_match (Str.regexp_string "+++") line 0
    then 
      File_info (fetch_file_name line)
  else if Str.string_match (Str.regexp_string "@@ ") line 0
    then 
      Line_info (fetch_line_number line)
  else
    No_info
     
    (*let line_first = String.sub line 0 1 in
      match line_first with
      | "+" -> fetch_file_name line
      | "@" -> fetch_line_number line 
      | _ ->  ()*)
 
let rec reorg_helper a = function 
[] -> (List.rev a, [])
| No_info :: tl -> reorg_helper a tl
| File_info file_list :: tl -> (List.rev a, File_info file_list :: tl)
| Line_info line_list :: tl ->  reorg_helper (line_list :: a) tl
;;    
let rec reorg = function 
[] -> []
| No_info :: tl -> reorg tl
| File_info file_list :: tl -> 
  let lines, rest = reorg_helper [] tl in
  {   
    file_name = file_list ;   
    line_no = lines;   
} :: reorg rest
   
| Line_info line_list :: tl ->  failwith "bad case"  

let () =
  let lines = bash_read_help "~/Elantris/snowflower/commit-parser" in
  List.iter extract_info lines
;;

(*let diff = read_whole_file "diff.txt"
let diff2 = read_whole_file "diff2.txt"
let d = Str.replace_first (Str.regexp "a/") "" *)