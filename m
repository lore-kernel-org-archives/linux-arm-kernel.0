From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jun 2012 10:05:41 -0700
Subject: [CFT 04/11] mmc: omap: add DMA engine support
In-Reply-To: <E1ScaYw-0003th-6i@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaYw-0003th-6i@rmk-PC.arm.linux.org.uk>
Message-ID: <20120607170541.GG12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120607 04:11]:
> Add DMA engine support to the OMAP driver.  This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This I boot tested on 770 and N800:

Tested-by: Tony Lindgren <tony@atomide.com>
