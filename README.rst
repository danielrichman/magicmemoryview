A helper / hack to allow us to cast a ``mmap.mmap`` or other buffer to
a Cython pointer of the correct type.

Cython is capable of casting a lot of things to a C pointer of the
correct type, especially with the aid of ``memoryview``. However,
in Python 2, ``memoryview`` lacks the ``memoryview.cast`` method
(so Cython won't let us change the dimensions of the array). Further,
both Python 2 and 3 require the memory map to be writable (making
the pointer type ``const`` does not seem to help here either).

This class takes a (possibly read-only) memmap object, and produces a
Python object with a ``__getbuffer__`` method that returns The Right Thing.
*It pretends that the underlying buffer is writable* to make Cython
happy. If you give it a read-only buffer, and try to write to the result,
then you will have a bad time.

When a Python object is cast by Cython to a pointer, it holds a
reference to the underlying Python object in order to prevent the
memory to which it refers being garbage collected. The ``MagicMemoryView``
in turn keeps a reference to the underlying data, so everything should
behave as expected.

Usage::

    from magicmemoryview import MagicMemoryView

    cdef double data[:, :, :]

    data = MagicMemoryView(source_buffer, (24, 12, 25), "d")
