From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Fri, 3 Dec 2010 01:34:54 +0530
Subject: [PATCH v5 09/14] OMAP: DMA: Convert DMA library into platform
	driver
In-Reply-To: <20101202184925.GT17222@atomide.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
	<1290603110-14119-10-git-send-email-manjugk@ti.com>
	<20101202184419.GR17222@atomide.com>
	<20101202184617.GS17222@atomide.com>
	<20101202184925.GT17222@atomide.com>
Message-ID: <20101202200454.GA27696@manju-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 10:49:25AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [101202 10:36]:
> > * Tony Lindgren <tony@atomide.com> [101202 10:34]:
> > > 
> > > This fails on omap1 as d is not allocated. Please merge the
> > > following fix.
> > 
> > And another fix here:
> 
> One more fix below.

Thanks. I will merge these fixes.

> 
> Note that even with these three fixes, 5912OSK still fails to
> boot to init. Maybe something wrong with the framebuffer DMA?

Not sure. I don't have omap1 board for testing. Patch series is only 
build tested for omap1.

Can you pls confirm if OSK5912 boots successfully without this patch
series?

If yes, I will cross verify omap1 changes again.

-Manjunath
