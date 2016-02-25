From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:52:55 +0900
Subject: [PATCH 1/2] arm64: renesas: Enable RENESAS_IRQC
In-Reply-To: <cover.1456442718.git.horms+renesas@verge.net.au>
References: <cover.1456442718.git.horms+renesas@verge.net.au>
Message-ID: <f7e020512e10a185d58d0f11faa57093345fd5b2.1456442718.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Select RENESAS_IRQC for Arm64 SoCs from Renesas to enable
build of drivers/irqchip/irq-renesas-irqc.c.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f674bde..757220cb1b7f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -77,6 +77,7 @@ config ARCH_RENESAS
 	select ARCH_SHMOBILE
 	select PINCTRL
 	select PM_GENERIC_DOMAINS if PM
+	select RENESAS_IRQC
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
 
-- 
2.7.0.rc3.207.g0ac5344
