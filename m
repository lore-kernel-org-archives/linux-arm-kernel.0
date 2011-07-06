From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:03 -0400
Subject: [PATCH 18/52] ARM: mach-ixp23xx: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-18-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ixp23xx/espresso.c   |    2 +-
 arch/arm/mach-ixp23xx/ixdp2351.c   |    2 +-
 arch/arm/mach-ixp23xx/roadrunner.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ixp23xx/espresso.c b/arch/arm/mach-ixp23xx/espresso.c
index e25e5fe..30dd316 100644
--- a/arch/arm/mach-ixp23xx/espresso.c
+++ b/arch/arm/mach-ixp23xx/espresso.c
@@ -88,6 +88,6 @@ MACHINE_START(ESPRESSO, "IP Fabrics Double Espresso")
 	.map_io		= ixp23xx_map_io,
 	.init_irq	= ixp23xx_init_irq,
 	.timer		= &ixp23xx_timer,
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= espresso_init,
 MACHINE_END
diff --git a/arch/arm/mach-ixp23xx/ixdp2351.c b/arch/arm/mach-ixp23xx/ixdp2351.c
index 8dcba17..566f56f 100644
--- a/arch/arm/mach-ixp23xx/ixdp2351.c
+++ b/arch/arm/mach-ixp23xx/ixdp2351.c
@@ -331,6 +331,6 @@ MACHINE_START(IXDP2351, "Intel IXDP2351 Development Platform")
 	.map_io		= ixdp2351_map_io,
 	.init_irq	= ixdp2351_init_irq,
 	.timer		= &ixp23xx_timer,
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= ixdp2351_init,
 MACHINE_END
diff --git a/arch/arm/mach-ixp23xx/roadrunner.c b/arch/arm/mach-ixp23xx/roadrunner.c
index 8fe0c62..611fdbc 100644
--- a/arch/arm/mach-ixp23xx/roadrunner.c
+++ b/arch/arm/mach-ixp23xx/roadrunner.c
@@ -174,6 +174,6 @@ MACHINE_START(ROADRUNNER, "ADI Engineering RoadRunner Development Platform")
 	.map_io		= ixp23xx_map_io,
 	.init_irq	= ixp23xx_init_irq,
 	.timer		= &ixp23xx_timer,
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= roadrunner_init,
 MACHINE_END
-- 
1.7.4
