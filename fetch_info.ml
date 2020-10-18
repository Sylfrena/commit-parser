open Printf
open Str

type diff_info = 
  | File_name  of Str.split_result list
  | Deletions  of int
  | Additions  of int
  | Addition_str  of string
  | Deletion_str  of string
  
let syname: string = "diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx."

let fileb = 
  let pat_filename = Str.regexp "a/\\(.+\\)b" in
  let s = Str.full_split pat_filename syname in
  s
 
let fileadd = 
  let pat_additon_str = Str.regexp "^(\+)[^+]" in
  Str.replace_first pat_additon_str "\\1" " +       if (!priv->rf_set_sens) {"
;;


let d = 1;;
let a = 2;;
let del = "hullo";;

let d1 =(
 File_name(fileb);
  Deletions(d);
  Additions(a); 
  Addition_str(fileadd); 
  Deletion_str(del))
   

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

let () = 
match d1 with
| Deletion_str i -> print_string i
| File_name b ->
  begin
    match b with 
    |None -> "endo"
    |hd::tl -> 
  end
| _ -> print_string "jullo"
;;



