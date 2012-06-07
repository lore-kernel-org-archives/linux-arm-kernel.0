From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jun 2012 10:06:32 -0700
Subject: [CFT 06/11] ARM: omap: remove mmc platform data dma_mask and
 initialization
In-Reply-To: <E1ScaZa-0003tu-OD@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaZa-0003tu-OD@rmk-PC.arm.linux.org.uk>
Message-ID: <20120607170631.GI12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120607 04:12]:
> DMAengine uses the DMA engine device structure when mapping/unmapping
> memory for DMA, so the MMC devices do not need their DMA masks
> initialized (this reflects hardware: the MMC device is not the device
> doing DMA.)
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Tony Lindgren <tony@atomide.com>
