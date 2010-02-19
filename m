From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Feb 2010 15:30:31 -0800
Subject: [PATCH 08/11] omap: musb: remove unused dma data
In-Reply-To: <20100219232648.10559.380.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Message-ID: <20100219233031.10559.39150.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <felipe.balbi@nokia.com>

we don't use those anywhere on musb driver, so
let's remove those old stuff.

Cc: linux-usb at vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-musb.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 01d86e5..4dfb66a 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -50,10 +50,7 @@ static struct resource musb_resources[] = {
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= 1,
 	.dyn_fifo	= 1,
-	.dma		= 1,
 	.num_eps	= 16,
-	.dma_channels	= 7,
-	.dma_req_chan	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
 	.ram_bits	= 12,
 };
 
