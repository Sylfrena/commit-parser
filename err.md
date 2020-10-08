```

let file = "diff.txt"

let parse_file = 
  let ic = open_in file in
  try
    while true do
      let line =
        match (input_line ic).[0] with
        |'-' -> input_line ic 
        |'+' -> input_line ic
        | _  -> ""  in
    done
  with 
    End_of_file -> close_in ic 
```
