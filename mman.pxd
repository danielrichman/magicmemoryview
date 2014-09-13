cdef extern from "sys/mman.h" nogil:
    enum: MADV_NORMAL
    enum: MADV_RANDOM
    enum: MADV_SEQUENTIAL
    enum: MADV_WILLNEED
    enum: MADV_DONTNEED
    enum: MADV_REMOVE
    enum: MADV_DONTFORK
    enum: MADV_DOFORK
    enum: MADV_HWPOISON
#    enum: MADV_SOFT_OFFLINE
    enum: MADV_MERGEABLE
    enum: MADV_UNMERGEABLE
    enum: MADV_HUGEPAGE
    enum: MADV_NOHUGEPAGE
#    enum: MADV_DONTDUMP
#    enum: MADV_DODUMP

    int madvise(void *addr, size_t length, int advice)
