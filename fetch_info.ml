open Printf
open Str

let bash_help =
  let ic = Unix.open_process_in "cd ~/Elantris/meshery && git diff" in 
  let all_input = ref [] in 
  try
    while true do
      all_input := input_line ic :: !all_input
    done
  with
    End_of_file -> close_in ic;
    List.iter print_endline !all_input



type diff_info = 
{   
    file_name: Str.split_result list; 
    deletions: int;
    additions: int;
    line_no: (int * int) list;
}
  
let syname: string = "diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx."

let fileb = 
  let pat_filename = Str.regexp "a/\\(.+\\)b" in
  let s = Str.full_split pat_filename syname in
  s

let c = "a/dri..."
let reg = Str. regexp "a/"
let d = Str.replace_first reg "" c
 
let fileadd = 
  let pat_additon_str = Str.regexp "^(\+)[^+]" in
  Str.replace_first pat_additon_str "\\1" " +       if (!priv->rf_set_sens) {"
;;


let d = 1
let a = 2
let del = "hullo"

let c = "a/dri..."
let reg = Str. regexp "a/"
let d = Str.replace_first (Str.regexp "a/") "" c


(*let d1: diff_info =
{
  file_name(fileb);
  deletions(d);
  additions(a); 
  addition_str(fileadd); 
  deletion_str(del)
}*)
   

(*let print_list_string (myList: split_result list) = 
match myList with
| [] -> print_endline "This is the end of the string list!"
| head::body -> 
begin
print_endline head.Text;
print_list_string body
end
;;
printf "%s\n\n" fileadd;
printf "%s%s" fileb
*)

let () = printf "%s" d;;




(*match d1 with
| Deletion_str i -> print_string i
| File_name b ->
  begin
    match b with 
    |None -> "endo"
    |hd::tl -> 
  end
| _ -> print_string "jullo"
;;*)


