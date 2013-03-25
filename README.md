Copyright Updater
=================

This plugin will automatically update Copyright notices for specific Copyright
owners.  This is based on VIM tip #1521.

The plugin recognises the following examples of Copyright notice:

	Copyright 1999 Fred Bloggs, All rights reserved.
	Copyright (C) 1999 Fred Bloggs, All rights reserved.
	Copyright (c) 1999-2005 Fred Bloggs

Whenever a file that has been modified is written then the year of publication
is updated to include the current year if it is different. If only one year is
listed then it is changed to YYYY-<current year>, if two years are listed and
the second year is not this year then the second year is updated to this year.

The plugin is setup by telling it which Copyright owners to update the notice
for. This prevents accidentally updating Copyright notices from other owners
that may be present in the file.

To setup updating a Copyright notice add a call to `copyright#UpdateFor()` to
your `.vimrc`/`_vimrc` file as follows:

```vim
call copyright#UpdateFor('Fred Bloggs')
```

Add as many Copyright owners as needed to the call.

License
=======

Copyright (c) 2009-2013 Mike Williams <mrmrdubya@gmail.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
