From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Jul 2010 08:23:22 +0100
Subject: Your patch: ARM: AMBA: Add pclk definition for platforms using
	primecells
In-Reply-To: <0D753D10438DA54287A00B02708426976374051D65@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B02708426976374051D65@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100721072322.GA6009@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 20, 2010 at 06:54:18PM -0500, H Hartley Sweeten wrote:
> Hello Russell,
> 
> Your patch added a new clock to the ep93xx platform called "apb_pclk".  This
> clock was already available as "pclk" on that platform.
> 
> Since there are no users of "pclk" in the kernel I have no problems just
> renaming it to "apb_pclk" and removing the dummy_apb_pclk that you added.
> 
> Would you like me to submit the ncessary patch or can you fix it?

I'd prefer to fix it in the original patch, because that will solve
the merge conflict which SFR is seeing.  First, has such a change
been tested?
