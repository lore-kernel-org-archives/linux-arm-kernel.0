From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jan 2014 14:03:04 -0800
Subject: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
In-Reply-To: <20140113212815.GH27282@n2100.arm.linux.org.uk>
References: <20140109152437.GB27282@n2100.arm.linux.org.uk>
 <20140113141811.GD27282@n2100.arm.linux.org.uk>
 <20140113173744.GA7746@atomide.com>
 <20140113185503.GE27282@n2100.arm.linux.org.uk>
 <20140113192630.GB7746@atomide.com>
 <20140113203404.GF27282@n2100.arm.linux.org.uk>
 <20140113210242.GA7993@atomide.com>
 <20140113211130.GG27282@n2100.arm.linux.org.uk>
 <20140113212117.GB7993@atomide.com>
 <20140113212815.GH27282@n2100.arm.linux.org.uk>
Message-ID: <20140113220304.GC7993@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 13:30]:
> On Mon, Jan 13, 2014 at 01:21:18PM -0800, Tony Lindgren wrote:
> > Yes that's correct, here are all the DMA related lines:
> > 
> > DMA: preallocated 256 KiB pool for atomic coherent allocations
> > OMAP DMA hardware version 1
> > DMA capabilities: 0000000c:00000000:01ff:003f:007f
> > omap-dma-engine omap-dma-engine: failed to get L1 IRQ: -6
> > omap-dma-engine omap-dma-engine: OMAP DMA engine driver
> > omap-dma-engine omap-dma-engine: allocating channel 0 for 54
> > omap-dma-engine omap-dma-engine: allocating channel 1 for 55
> > DMA timeout with device 55
> 
> Hmm, that's annoying, and will be annoying to debug remotely.  Would
> you like a new set of patches to try bisecting to find the culpret?

Sure that would help.

Regards,

Tony
