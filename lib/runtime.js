//Provides: bigstring_memchr
//Requires: caml_ba_get_1
function bigstring_memchr(haystack, needle, pos, len) {
  for (var i = 0; i < len; i++) {
    if(caml_ba_get_1(haystack, pos + i) == needle) {
      return (pos + i);
    }
  }
  return -1;
}

//Provides: string_memchr
//Requires: caml_string_unsafe_get
function string_memchr(haystack, needle, pos, len) {
  for (var i = 0; i < len; i++) {
    if(caml_string_unsafe_get(haystack, pos + i) == needle) {
      return (pos + i);
    }
  }
  return -1;
}

//Provides: bytes_memchr
//Requires: caml_bytes_unsafe_get
function bytes_memchr(haystack, needle, pos, len) {
  for (var i = 0; i < len; i++) {
    if(caml_bytes_unsafe_get(haystack, pos + i) == needle) {
      return (pos + i);
    }
  }
  return -1;
}
