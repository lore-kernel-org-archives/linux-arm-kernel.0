From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jan 2014 14:14:26 -0800
Subject: [PATCH RFC 08/26] dmaengine: omap-dma: consolidate setup of CCR
In-Reply-To: <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk>
Message-ID: <20140113221425.GD7993@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140102 07:17]:
> Consolidate the setup of the channel control register.  Prepare the
> basic value in the preparation of the DMA descriptor, and write it into
> the register upon descriptor execution.

FYI, this patch seems to be the one that causes the
"DMA timeout with device 55" error for omap1.

Tony
