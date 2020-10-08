
open Printf
open Str

let syname: string = "diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx."

let tonton = 
  let pat_filename = Str.regexp "a\/(.+)b" in
  let _ = Str.search_forward pat_filename syname in
  Str.matched_string syname
;;

printf "%s" tonton;