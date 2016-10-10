From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Oct 2016 15:18:19 +0100
Subject: MAINTAINERS entry for ARM/CLKDEV SUPPORT
In-Reply-To: <20161010140810.GA30609@mwanda>
References: <20161010140810.GA30609@mwanda>
Message-ID: <20161010141819.GA1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 05:08:10PM +0300, Dan Carpenter wrote:
> Hello Stephen Boyd,

Okay, that's really not nice.

This is _not_ a question for Stephen.  Stephen does _not_ co-maintain
clkdev or the clk API, but co-maintains CCF.  I've no idea why you are
addressing this to Stephen when this is clearly a question for me to
answer.

> The MAINTAINERS entry looks like this:
> 
> ARM/CLKDEV SUPPORT
> M:      Russell King <linux@armlinux.org.uk>
> L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> S:      Maintained
> F:      arch/arm/include/asm/clkdev.h
> F:      drivers/clk/clkdev.c
> 
> 
> We removed arch/arm/include/asm/clkdev.h in 34d2f4d3a4d6a6b ('ARM: Use
> generic clkdev.h header').  Do you still need to be CC'd on the clkdev.c
> changes?

Technically, it is redundant anyway, as I'm listed for all arch/arm
changes.  However, the maintainership of arch/arm and the maintainership
of clkdev are separate, the explicit entry is quite right.

It's also right that it's retained, because if we stop using the generic
clkdev.h header, I want to be copied on such a change, and this entry
will allow checkpatch to list me as clkdev maintainer.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
