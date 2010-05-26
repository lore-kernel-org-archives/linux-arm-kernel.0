From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Wed, 26 May 2010 08:23:16 +0200
Subject: [PATCH] ARM: TCM memory bug on newer compilers
In-Reply-To: <20100525201632.GC16204@n2100.arm.linux.org.uk>
References: <1274805947-414-1-git-send-email-linus.walleij@stericsson.com>
	<20100525201632.GC16204@n2100.arm.linux.org.uk>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025A7D7D1B@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Russell]

> On Tue, May 25, 2010 at 06:45:47PM +0200, Linus Walleij wrote:
> > Apparently newer compilers don't like you to refer to linker
> > symbols as extern char *foo, we must use char foo and refer to
> > the address of the char instead.
> 
> afaik, that's always been the case.

Thanks a lot of the education session Russell, I get it now.
What I don't get is how this code worked on earlier GCC:s :-P

Anyway, I'll put the patch in the tracker with a new patch
description that is more enlightened.

Yours,
Linus Walleij
