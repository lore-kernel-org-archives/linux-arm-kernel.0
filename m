From: pwaechtler@mac.com (Peter =?iso-8859-1?q?W=E4chtler?=)
Date: Fri, 8 Apr 2011 18:25:46 +0200
Subject: Fwd: Re: howto set some kernel pages to readonly?
Message-ID: <201104081825.46632.pwaechtler@mac.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 8. April 2011, 00:04:07 schrieben Sie:

> We don't map kernel space using pages, but section mappings which have a
> granularity of 1MB.

>That makes it difficult to set read-only status on just small areas of
>memory because you'd have to ensure that the .rodata starts at a 1MB
>boundary, and the following data also starts at a 1MB boundary - which
>would be quite wasteful.

OK, then what do I have to do, to set a section of 1MB to readonly?
It's really meant as a guard - I have to find some memory corruption 
potentially caused by a driver... 

I use the slab cache to allocate - now - a 1 MB section - how to protect this 
section as readonly?

--
   Peter
