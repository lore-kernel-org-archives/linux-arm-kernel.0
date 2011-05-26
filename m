From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 May 2011 22:53:49 +0100
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <0D753D10438DA54287A00B027084269764D3319EC4@AUSP01VMBX24.collaborationhost.net>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
	<BANLkTi=3z3kO5VEe2up8Mfm+bNXkY3baUw@mail.gmail.com>
	<20110525195413.GC2996@acer>
	<BANLkTin8Trn-44Op+GbxrgocFrnPuXUZ2w@mail.gmail.com>
	<20110526043344.GA2749@acer>
	<BANLkTikzrXRmdnv_v_nmJw7Nvsr6TY-5RQ@mail.gmail.com>
	<20110526183800.GE2957@acer>
	<0D753D10438DA54287A00B027084269764D3319EC4@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110526215349.GM24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 01:48:12PM -0500, H Hartley Sweeten wrote:
> I think the biggest hurdle with using the amba-pl022 driver is that the ep93xx
> spi peripheral does not have the registers with the pid and cid id's.  Without
> those I don't think the amba bus driver will be able to match the device to
> the driver.

I've just committed Linus' patches to allow a provided ID to override
what the bus code finds.
