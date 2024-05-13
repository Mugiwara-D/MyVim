" Function to create a C++ class with a header and source file
function! CreateCppClass()
  " Prompt for the class name
  let className = input("Enter class name: ")

  " Check if the user provided a class name
  if className == ""
    echo "Class name is required"
    return
  endif

  " Define file names
  let hppFileName = className . ".hpp"
  let cppFileName = className . ".cpp"

  " Check if the files already exist
  if filereadable(hppFileName)
    echo hppFileName . " already exists."
    return
  endif

  if filereadable(cppFileName)
    echo cppFileName . " already exists."
    return
  endif

  " Create the header file
  call writefile([
        \ "#ifndef " . toupper(className) . "_HPP",
        \ "#define " . toupper(className) . "_HPP",
        \ "",
        \ "class " . className . " {",
        \ "public:",
        \ "    " . className . "();",
        \ "    ~" . className . "();",
        \ "};",
        \ "",
        \ "#endif // " . toupper(className) . "_HPP"
        \], hppFileName)

  " Create the source file
  call writefile([
        \ "#include \"" . hppFileName . "\"",
        \ "",
        \ className . "::" . className . "() {",
        \ "    // Constructor implementation",
        \ "}",
        \ "",
        \ className . "::~" . className . "() {",
        \ "    // Destructor implementation",
        \ "}"
        \], cppFileName)

  echo "Created " . hppFileName . " and " . cppFileName
endfunction

" Map a key to run the function
nnoremap <leader>cc :call CreateCppClass()<CR>
