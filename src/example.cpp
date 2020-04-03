#include <Rcpp.h>
using namespace Rcpp;


static void ptrFinalizer(SEXP extPtr) {
  Rprintf("finalizing data\n");
  Function func = R_ExternalPtrTag(extPtr);
  SEXP path = R_ExternalPtrProtected(extPtr);
  func(path);
  return;
}

// [[Rcpp::export]]
SEXP makeExtPtr(SEXP func, SEXP path) {
  void* ptr = NULL;
  SEXP ExtPtr = PROTECT(R_MakeExternalPtr(ptr, func, path));
  R_RegisterCFinalizer(ExtPtr, ptrFinalizer);
  UNPROTECT(1);
  return ExtPtr;
}

