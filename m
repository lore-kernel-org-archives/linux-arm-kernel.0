From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jun 2012 10:04:42 -0700
Subject: [CFT 02/11] mmc: omap_hsmmc: add DMA engine support
In-Reply-To: <E1ScaYH-0003tV-Bn@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaYH-0003tV-Bn@rmk-PC.arm.linux.org.uk>
Message-ID: <20120607170440.GE12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120607 04:11]:
> Add DMA engine support to the OMAP HSMMC driver.  This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
> 
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Gave this quick boot test on 2430sdp, zoom3, n900 and blaze:

Tested-by: Tony Lindgren <tony@atomide.com>
