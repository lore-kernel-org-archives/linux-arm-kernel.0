From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 18 Dec 2010 02:42:16 -0700 (MST)
Subject: [PATCH v2 4/9] OMAP2430: hwmod data: add system DMA
In-Reply-To: <20101218093741.GC3047@n2100.arm.linux.org.uk>
References: <1292600388-13094-1-git-send-email-manjugk@ti.com>
	<1292600388-13094-5-git-send-email-manjugk@ti.com>
	<alpine.DEB.2.00.1012180203380.16875@utopia.booyaka.com>
	<20101218093741.GC3047@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1012180241140.16875@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 18 Dec 2010, Russell King - ARM Linux wrote:

> I'm confused.  I thought the whole point of hwmod was that the data for
> it was generated from a TI database of how the chip is actually setup.
> 
> However, from all the patching which seems to be going on, it looks to
> me like that's not the case - and if that's true, hwmod was mis-sold.
> It's just moved the problem rather than solving anything.
> 
> What's going on?

OMAP4 and beyond data is being generated from the TI hardware database.  
However, apparently that is not possible with the OMAP2 and OMAP3 data.


- Paul
