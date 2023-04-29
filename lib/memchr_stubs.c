#include <caml/bigarray.h>
#include <caml/mlvalues.h>
#include <string.h>

CAMLprim value bigstring_memchr(value haystack, value needle, value pos,
                                value len) {
  char *buf = (char *)Caml_ba_data_val(haystack) + Unsigned_long_val(pos);
  char *result = memchr(buf, Int_val(needle), Unsigned_long_val(len));
  if (result == NULL) {
    return Val_long(-1);
  } else {
    return Val_long(Unsigned_long_val(pos) + result - buf);
  }
}

CAMLprim value string_memchr(value haystack, value needle, value pos,
                             value len) {
  char *buf = ((char *)String_val(haystack)) + Unsigned_long_val(pos);
  char *result = memchr(buf, Int_val(needle), Unsigned_long_val(len));
  if (result == NULL) {
    return Val_long(-1);
  } else {
    return Val_long(Unsigned_long_val(pos) + result - buf);
  }
}

CAMLprim value bytes_memchr(value haystack, value needle, value pos,
                            value len) {
  char *buf = ((char *)Bytes_val(haystack)) + Unsigned_long_val(pos);
  char *result = memchr(buf, Int_val(needle), Unsigned_long_val(len));
  if (result == NULL) {
    return Val_long(-1);
  } else {
    return Val_long(Unsigned_long_val(pos) + result - buf);
  }
}
