From: bmpenrod@endruntechnologies.com (Bruce M. Penrod)
Date: Mon, 13 Sep 2010 00:40:56 -0700
Subject: Maximum bootable kernel size in current ARM linux
Message-ID: <4C8DD588.7040009@endruntechnologies.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This seems like a pretty straightforward question, but extensive web 
searching hasn't shown a really clear, up-to-date answer.  The most 
recent info is circa 2004 and states that 4MB is the largest 
uncompressed ARM kernel that may be loaded.  Not being an ARM assembly 
guru (head.S baffles me), I'd like to know if that is still true in 
2010, and if it is, why?

I'm having one hell of a time compiling a monolithic kernel and keeping 
it under 4M without leaving out some core networking features I need. 
 From my searching, it looks like x86 has either removed the limit or 
raised it to a much higher number.  It's not clear to me why a 32 bit 
processor would not be able to boot a kernel larger than 4 MB.

Bruce
