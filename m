From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jun 2012 10:04:58 -0700
Subject: [CFT 03/11] mmc: omap_hsmmc: remove private DMA API implementation
In-Reply-To: <E1ScaYb-0003tZ-Pb@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaYb-0003tZ-Pb@rmk-PC.arm.linux.org.uk>
Message-ID: <20120607170456.GF12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120607 04:11]:
> Remove the private DMA API implementation from omap_hsmmc, making it
> use entirely the DMA engine API.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Tony Lindgren <tony@atomide.com>
