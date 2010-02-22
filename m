From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2010 15:07:12 -0800
Subject: [PATCH 1/9] omap3/4: uart: fix full-fifo write abort
In-Reply-To: <20100222213932.GW18786@atomide.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C417FA42@dbde02.ent.ti.com>
	<20100222213932.GW18786@atomide.com>
Message-ID: <20100222230712.GB18786@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100222 13:35]:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100218 21:22]:
> > Bye the way just to add bit more clarity, this patch addresses TX
> > hardware restriction in the new UART IP used on omap3630 and omap4430.
> > First part of the fix for RX is already in mainline,
> > Commit: "ce13d4716a276f4331d78ba28a5093a63822ab95"
> > 
> > More details on this thread are here.
> > http://www.mail-archive.com/linux-omap at vger.kernel.org/msg19447.html
> 
> Thanks, I've updated the comments for this patch with the link above
> and added the whole series into omap for-next.

Except patches 8 and 9 as they break compile for mach-omap1
and need to be updated.

Regards,

Tony
