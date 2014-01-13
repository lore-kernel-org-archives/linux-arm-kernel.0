From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jan 2014 21:28:16 +0000
Subject: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
In-Reply-To: <20140113212117.GB7993@atomide.com>
References: <20140108012110.GL5074@atomide.com>
 <20140109152437.GB27282@n2100.arm.linux.org.uk>
 <20140113141811.GD27282@n2100.arm.linux.org.uk>
 <20140113173744.GA7746@atomide.com>
 <20140113185503.GE27282@n2100.arm.linux.org.uk>
 <20140113192630.GB7746@atomide.com>
 <20140113203404.GF27282@n2100.arm.linux.org.uk>
 <20140113210242.GA7993@atomide.com>
 <20140113211130.GG27282@n2100.arm.linux.org.uk>
 <20140113212117.GB7993@atomide.com>
Message-ID: <20140113212815.GH27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 01:21:18PM -0800, Tony Lindgren wrote:
> Yes that's correct, here are all the DMA related lines:
> 
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> OMAP DMA hardware version 1
> DMA capabilities: 0000000c:00000000:01ff:003f:007f
> omap-dma-engine omap-dma-engine: failed to get L1 IRQ: -6
> omap-dma-engine omap-dma-engine: OMAP DMA engine driver
> omap-dma-engine omap-dma-engine: allocating channel 0 for 54
> omap-dma-engine omap-dma-engine: allocating channel 1 for 55
> DMA timeout with device 55

Hmm, that's annoying, and will be annoying to debug remotely.  Would
you like a new set of patches to try bisecting to find the culpret?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
