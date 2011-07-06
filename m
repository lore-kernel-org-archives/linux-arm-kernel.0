From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:13 -0400
Subject: [PATCH 28/52] ARM: mach-nomadik: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-28-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-nomadik/board-nhk8815.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 1399303..398a75f 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -276,7 +276,7 @@ static void __init nhk8815_platform_init(void)
 
 MACHINE_START(NOMADIK, "NHK8815")
 	/* Maintainer: ST MicroElectronics */
-	.boot_params	= 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= cpu8815_map_io,
 	.init_irq	= cpu8815_init_irq,
 	.timer		= &nomadik_timer,
-- 
1.7.4
