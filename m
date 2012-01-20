From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 09:27:08 +0000
Subject: [PATCH 14/31] ARM: amba: netx: get rid of NO_IRQ initializers
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoAkW-0005FD-UH@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-netx/fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-netx/fb.c b/arch/arm/mach-netx/fb.c
index b991323..eda856c 100644
--- a/arch/arm/mach-netx/fb.c
+++ b/arch/arm/mach-netx/fb.c
@@ -102,7 +102,7 @@ static struct amba_device fb_device = {
 		.end	= 0x00104fff,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { NETX_IRQ_LCD, NO_IRQ },
+	.irq		= { NETX_IRQ_LCD },
 };
 
 int netx_fb_init(struct clcd_board *board, struct clcd_panel *panel)
-- 
1.7.4.4
