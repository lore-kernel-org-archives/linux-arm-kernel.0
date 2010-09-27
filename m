From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:40 +0200
Subject: [PATCH 04/40] ARM: mx5/mx51_babbage: don't use PHYS_OFFSET
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 3ef1214..caa8f68 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -324,7 +324,7 @@ MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
 	/* Maintainer: Amit Kucheria <amit.kucheria@canonical.com> */
 	.phys_io = MX51_AIPS1_BASE_ADDR,
 	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
-	.boot_params = PHYS_OFFSET + 0x100,
+	.boot_params = MX51_PHYS_OFFSET + 0x100,
 	.map_io = mx51_map_io,
 	.init_irq = mx51_init_irq,
 	.init_machine = mxc_board_init,
-- 
1.7.2.3
