From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:18 -0400
Subject: [PATCH 33/52] ARM: mach-pnx4008: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-33-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-pnx4008/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pnx4008/core.c b/arch/arm/mach-pnx4008/core.c
index 6339975..cdb95e7 100644
--- a/arch/arm/mach-pnx4008/core.c
+++ b/arch/arm/mach-pnx4008/core.c
@@ -264,7 +264,7 @@ extern struct sys_timer pnx4008_timer;
 
 MACHINE_START(PNX4008, "Philips PNX4008")
 	/* Maintainer: MontaVista Software Inc. */
-	.boot_params		= 0x80000100,
+	.atag_offset		= 0x100,
 	.map_io 		= pnx4008_map_io,
 	.init_irq 		= pnx4008_init_irq,
 	.init_machine 		= pnx4008_init,
-- 
1.7.4
