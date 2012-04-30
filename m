From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Apr 2012 08:59:38 -0700
Subject: [PATCH 07/12] mmc: omap: add DMA engine support
In-Reply-To: <20120428163716.GI28062@n2100.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLmZ-0002WS-Rd@rmk-PC.arm.linux.org.uk>
 <20120424001330.GD3739@atomide.com>
 <20120428163716.GI28062@n2100.arm.linux.org.uk>
Message-ID: <20120430155937.GB3739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120428 09:40]:
> On Mon, Apr 23, 2012 at 05:13:30PM -0700, Tony Lindgren wrote:
> > * Russell King <rmk+kernel@arm.linux.org.uk> [120423 09:11]:
> > > Add DMA engine support to the OMAP driver.  This supplements the
> > > private DMA API implementation contained within this driver, and the
> > > driver can be switched at build time between using DMA engine and the
> > > private DMA API.
> > 
> > Below is what's needed to use DMA request lines from platform data.
> > Note also the release_mem_region change that we'll now need for
> > this one also (but not as a fix).
> > 
> > I've posted a cleanup patch series to mostly remove plat-omap/devices.c
> > that takes care of passing the DMA request lines in platform data.
> > That series should get merged before the driver changes for this
> > driver to keep DMA working.
> 
> Okay, how do we want to handle this patch?  I don't think there's any
> urgency for this patch at the present time, so I'm quite happy for this
> to be delayed after the next merge window after we have the pre-requisits
> for it in place.  (And trying to get it in earlier is only going to give
> us git tree dependencies to deal with.)

Sounds good to me.

Regards,

Tony
