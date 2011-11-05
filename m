From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 5 Nov 2011 18:51:04 +0100
Subject: [PATCH] ARM: OMAP3: Fix dependencies for OMAP3_EMU
In-Reply-To: <20111105160020.GA15294@n2100.arm.linux.org.uk>
References: <1320512279-9032-1-git-send-email-weber@corscience.de>
	<20111105160020.GA15294@n2100.arm.linux.org.uk>
Message-ID: <201111051851.04879.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 November 2011, Russell King - ARM Linux wrote:
> On Sat, Nov 05, 2011 at 05:57:59PM +0100, Thomas Weber wrote:
> > This patch fixes the dependencies for OMAP3_EMU after
> > commit 53eebb0df85e4005
> > ARM: OC_ETM should not select ARM_AMBA
> > 
> > When "OMAP3 debugging peripherals" is selected the warning:
> > (OMAP3_EMU) selects OC_ETM which
> > has unmet direct dependencies (ARM_AMBA)
> 
> There is a patch from Arnd addressing this which was sent in October.
> It was acked by Santosh and Tony.  What happened to it?

I haven't gotten around to put the omap patches I sent earlier into
a branch yet, with too much travelling over the last weeks.

Right now, I'm mostly worried about regression fixes for stuff that
broke in the merge window, but the patches are not lost yet and
I'll get to that next, possibly only after I return from my vacation
in a week.

	Arnd
