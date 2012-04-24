From: tony@atomide.com (Tony Lindgren)
Date: Mon, 23 Apr 2012 17:17:20 -0700
Subject: [PATCH 06/12] mmc: omap_hsmmc: remove private DMA API
 implementation
In-Reply-To: <E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
Message-ID: <20120424001719.GF3739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120423 09:09]:
> Remove the private DMA API implementation from omap_hsmmc, making it
> use entirely the DMA engine API.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested on 770, n800, 2430sdp, n900, zoom3 and blaze:

Tested-by: Tony Lindgren <tony@atomide.com>
