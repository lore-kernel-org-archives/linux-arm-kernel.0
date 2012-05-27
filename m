From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Sun, 27 May 2012 13:39:26 +0100
Subject: arm: Remaining issue with alignment of __log_buf in printk.c
Message-ID: <4FC2207E.1080403@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

My stargate 2 board refused to start and after bisection I ended
up at the same patch that Stephen found an alignment issue in.
Unfortunately Stephen's patch doesn't seem to have fixed the
issue for me.
https://lkml.org/lkml/2012/5/10/510 is the thread.  Patch from
Stephen is : f8450fca6ecdea38b5a882fdf6cd097e3ec8651c

Increasing the alignement for 32 bit systems to 8 seems to do the
job but I can't immediately think why...

System is a pxa27x strong arm.

Tree was effectively today's mainline.

Saddly I have too many other bits to fit in today for futher
investigation (hence this information free email!)


Jonathan
