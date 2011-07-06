From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:48 -0400
Subject: [PATCH 03/52] ARM: mach-cns3xxx: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-cns3xxx/cns3420vb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index 08e5c87..a501f54 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -196,7 +196,7 @@ static void __init cns3420_map_io(void)
 }
 
 MACHINE_START(CNS3420VB, "Cavium Networks CNS3420 Validation Board")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= cns3420_map_io,
 	.init_irq	= cns3xxx_init_irq,
 	.timer		= &cns3xxx_timer,
-- 
1.7.4
