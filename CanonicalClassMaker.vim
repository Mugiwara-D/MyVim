" Function to create a C++ class with Orthodox Canonical Form
function! CreateCppClassOCF()
  " Prompt for class name
  let className = input("Enter class name: ")

  if className == ""
    echo "Class name is required"
    return
  endif

  " Define file names
  let hppFileName = className . ".hpp"
  let cppFileName = className . ".cpp"

  if filereadable(hppFileName) or filereadable(cppFileName)
    echo "Files already exist."
    return
  endif

  " Create the header file with guards and class declaration
  call writefile([
        \ "#ifndef " . toupper(className) . "_HPP",
        \ "#define " . toupper(className) . "_HPP",
        \ "",
        \ "#include <iostream>",
        \ "",
        \ "class " . className,
		\ "{",
        \ "	private:",
        \ "		std::string	data;",  
        \ "",
        \ "	public:",
        \ "		" . className . "();",
        \ "		" . className . "( const char* str );",
        \ "		" . className . "( const " . className . "& src );",
        \ "		" . className . "& operator=( const " . className . "& src );",
        \ "		~" . className . "();", 
        \ "",
        \ "		void	get() const;",
		\ "		void	set() const;",
        \ "};",
        \ "",
		\ "std::ostream&   operator<<( std::ostream& o, const " . className . "& rhs );",
		\ "",
        \ "#endif // " . toupper(className) . "_HPP"
        \], hppFileName)

  " Create the source file with implementations
  call writefile([
        \ "#include \"" . hppFileName . "\"",
        \ "",
        \ className . "::" . className . "() : data(nullptr) {",
        \ "    std::cout << \"Default constructor called\" << std::endl;",
        \ "}",
        \ "",
        \ className . "::" . className . "() {",
        \ "    std::cout << \"Parameterized constructor called\" << std::endl;",
        \ "}",
        \ "",
        \ className . "::" . className . "(const " . className . "& src) {",
        \ "    std::cout << \"Copy constructor called\" << std::endl;",
        \ "}",
        \ "",
        \ className . "& " . className . "::operator=(const " . className . "& src) {",
        \ "}",
        \ "",
        \ className . "::~" . className . "() {",
        \ "}",
        \ "",
        \], cppFileName)

  echo "Created " . hppFileName . " and " . cppFileName
endfunction

" Map a key to run the function
nnoremap <leader>cm :call CreateCppClassOCF()<CR>
