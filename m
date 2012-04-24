From: tony@atomide.com (Tony Lindgren)
Date: Mon, 23 Apr 2012 17:16:32 -0700
Subject: [PATCH 05/12] mmc: omap_hsmmc: add DMA engine support
In-Reply-To: <E1SMLlv-0002WI-8a@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLlv-0002WI-8a@rmk-PC.arm.linux.org.uk>
Message-ID: <20120424001631.GE3739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120423 09:09]:
> Add DMA engine support to the OMAP HSMMC driver.  This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested on 770, n800, 2430sdp, n900, zoom3 and blaze:

Tested-by: Tony Lindgren <tony@atomide.com>
