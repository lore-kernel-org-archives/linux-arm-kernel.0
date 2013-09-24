From: csd@broadcom.com (Christian Daudt)
Date: Tue, 24 Sep 2013 13:18:59 -0700
Subject: [PATCH] ARM: bcm281xx: more descriptive machine string
Message-ID: <1380053939-11329-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SoC model to DT_MACHINE_START string.

Signed-off-by: Christian Daudt <bcm@fixthebug.org>
Reviewed-by: Markus Mayer <mmayer@broadcom.com>
Reviewed-by: Mark Hambleton <mahamble@broadcom.com>
Reviewed-by: James King <jamesk@broadcom.com>

diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
index 8d9f931..dcfaf4a 100644
--- a/arch/arm/mach-bcm/board_bcm281xx.c
+++ b/arch/arm/mach-bcm/board_bcm281xx.c
@@ -67,7 +67,7 @@ static void __init board_init(void)
 
 static const char * const bcm11351_dt_compat[] = { "brcm,bcm11351", NULL, };
 
-DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
+DT_MACHINE_START(BCM11351_DT, "BCM281xx Broadcom Application Processor")
 	.init_time = clocksource_of_init,
 	.init_machine = board_init,
 	.restart = bcm_kona_restart,
-- 
1.7.10.4
