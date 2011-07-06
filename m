From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:08 -0400
Subject: [PATCH 23/52] ARM: mach-lpc32xx: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-23-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-lpc32xx/phy3250.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 7993b09..9b621e1 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -382,7 +382,7 @@ arch_initcall(lpc32xx_display_uid);
 
 MACHINE_START(PHY3250, "Phytec 3250 board with the LPC3250 Microcontroller")
 	/* Maintainer: Kevin Wells, NXP Semiconductors */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.map_io		= lpc32xx_map_io,
 	.init_irq	= lpc32xx_init_irq,
 	.timer		= &lpc32xx_timer,
-- 
1.7.4
