From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 15 Dec 2010 07:29:46 +0530
Subject: [PATCH v1 0/9] OMAP: DMA: hwmod and DMA as platform device
In-Reply-To: <87tyifn7ed.fsf@deeprootsystems.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
	<87tyifn7ed.fsf@deeprootsystems.com>
Message-ID: <20101215015946.GA6725@manju-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin/Tony,

On Tue, Dec 14, 2010 at 05:37:14PM -0800, Kevin Hilman wrote:
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > Patch series to convert DMA library into platform driver using platform
> > device model and adapting hwmod for omap2+.
> 
> After the OMAP1 fixup for PATCH 7/9,
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> and
> 
> Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> on omap1611/OSK, omap3430/n900 and omap4430/panda
> 
> Tested using a memory-to-memory DMA test which tests all available
> channels, and tests linking all the channels together.
> 
> I resurected an older DMA test that I wrote sometime around 2004, and
> lost somehow (thankfully, Tony still had a copy.)  I've updated it
> slightly and created a git repo for it now that it is known working on
> OMAP1, 2, 3 and 4.
> 
>        git://gitorious.org/omap-test/dmatest.git

Nice. TI too has exhaustive memory to memory test cases available at
public git repo(includes other driver test cases as well):

git://dev.omapzoom.org/pub/scm/richo/device_driver_test.git

> 
> It's a bit hacky as you have to manually edit the Makefile to build an
> out of tree module, but it does work.

Thanks for fixing OMAP1 irq issues and testing the same. I hope we will
have OSK5912 for future patches and we will test all upstream patches on
OMAP1 too.

-Manjunath
