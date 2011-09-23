From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Sep 2011 16:08:45 -0700
Subject: [PATCH 07/11] OMAP2+: board-generic: Add DT support to generic
	board
In-Reply-To: <1316809399-19579-8-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
	<1316809399-19579-8-git-send-email-b-cousson@ti.com>
Message-ID: <20110923230845.GD6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [110923 12:50]:
> Re-cycle the original board-generic file to support Device Tree
> for every OMAP2+ variants.
> Note: Since it is a completely new content in the existing file
> I removed the original copyright.

I'd suggest just keeping it, maybe just update the comments
accordingly?

That's because Copyrights in general just don't "disappear".

And the meaning of the board-generic is still the same as originally,
that is do the booting based on board-specific data passed from
the bootloader like the comments say:

> - * Code for generic OMAP2 board. Should work on many OMAP2 systems where
> - * the bootloader passes the board-specific data to the kernel.
> - * Do not put any board specific code to this file; create a new machine
> - * type if you need custom low-level initializations.
> + * Support for generic OMAP2+ device tree boards.

Regards,

Tony
