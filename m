From: tony@atomide.com (Tony Lindgren)
Date: Sat, 30 Jan 2010 08:18:13 -0800
Subject: [PATCH 0/9] Initial multi-omap support for omap4
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C0A68EB3@dbde02.ent.ti.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C0A68EB3@dbde02.ent.ti.com>
Message-ID: <20100130161813.GP23505@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100130 03:07]:
> Tony,
> > -----Original Message-----
> > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Tony
> > Lindgren
> > Sent: Saturday, January 30, 2010 7:31 AM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: linux-omap at vger.kernel.org
> > Subject: [PATCH 0/9] Initial multi-omap support for omap4
> > 
> > Hi all,
> > 
> > These patches allow compiling in also omap4 into the multi-omap
> > configuration. As I don't yet have omap4, I've only boot tested
> > these on omap2 and omap3.
> > 
> > Somebody with an omap4 board please boot test these with the
> > omap3_defconfig and see what happens.. You might want to enable
> > DEBUG_LL and EARLY_PRINTK with earlyprintk on the cmdline too.
> Looks like this series have some dependent series because it doesn't
> apply on mainline.

Sorry, forgot to mention that these are against the earlier
multi-omap patches. Basically stuff that's now queued for the
merge window in the omap-for-linus branch.

> So I tested this directly on linux-omap "multi-omap4" branch. It boots sufficiently
> but doesn't proceed after "brd_init". Didn't get much time to debug so attached log

Thanks for testing. Yeah these same are in the multi-omap4
branch also.

Regards,

Tony
