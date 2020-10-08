open Printf
open Str

type diff_info = 
  {
    file_name : string list;
    deletions : int;
    additions : int;
    addition_str: string;
    deletion_str: string;
  }



let syname: string = "diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx."

let fileb = 
  let pat_filename = Str.regexp "a\/(.+)b" in
  let s = Str.full_split pat_filename syname in
  s
 
let fileadd = 
  let pat_additon_str = Str.regexp "^(\+)[^+]" in
  Str.replace_first pat_additon_str "\\1" " +       if (!priv->rf_set_sens) {"
;;

let d = 1
let a = 2
let del = "who cares"

(*let d1: diff_info = 
  {file_name=fileb.;
  deletions=d;
  additions=a; 
  addition_str=fileadd; 
  deletion_str=del}
;;*)
   

let print_list_string (myList: split_result list) = 
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

