From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 31 Aug 2013 11:03:29 +0530
Subject: Query about include/linux/mailbox.h
In-Reply-To: <522177C4.8060205@yahoo.com.au>
References: <522177C4.8060205@yahoo.com.au>
Message-ID: <CABb+yY3wX2=1zh-F81YhhhgM6m+m4+fpVoKDn94m-febAhZGRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 10:27 AM, Craig McGeachie <slapdau@yahoo.com.au> wrote:
>
> Hello,
>
> At the end of all this, my question is should I put the BCM2835 mailbox driver in drivers somewhere, and try to make use of include/linux/mailbox.h, or should go with the view that mailbox drivers are inherently machine specific, have no common driver framework, and belongs in arch/arm/mach-bcm2835?
>
> The background to this is that I'm trying to help bring Raspberry Pi support into the mainline kernel. Lubomir Rintel coded a mailbox driver [1] that I liked the look off and want to fix up and push upstream. Stephen Warren suggested that Lubmir's patch had the benefit of using a new mailbox sub-system [2] and that I should have a look at that.
>
> I've looked at include/linux/mailbox.h, and it only has 3 function declarations, which are all specific to the PL320.  Unless there is something I've missed, then there is no mailbox sub-system to speak of.  Just a header file that will quickly a dependency nightmare.
>
> I found a patch submission series from Jassi Brar [3] that looks like the start of an actual mailbox framework, but there is no indication of it in the current kernel source.  I assume it was dropped for some reason.
>
It wasn't dropped.
Just the development was taken offline by the three of us I (for
Fujitsu), Suman Anna (for TI) and Loic (for STE).  Later we were
joined by LF.Tan (for Intel). Please join us.
 https://github.com/sumananna/mailbox/commits/jassiv3-3.10-omap should
be good to base on.

Thanks,
Jassi
