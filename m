From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Jun 2013 16:28:21 +0900
Subject: [PATCH 3/5] ARM: shmobile: r8a7778: correct model name in Kconfig
In-Reply-To: <1370503703-31024-1-git-send-email-horms+renesas@verge.net.au>
References: <1370503703-31024-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370503703-31024-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The correct model name is R-Car M1A or R8A77781; R8A77780 corresponds to R-Car
M1S which is a SH based SoC.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[horms+renesas at verge.net.au: manually applied]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 1a517e2..52e8c6e 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -36,7 +36,7 @@ config ARCH_R8A7740
 	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7778
-	bool "R-Car M1 (R8A77780)"
+	bool "R-Car M1A (R8A77781)"
 	select CPU_V7
 	select SH_CLK_CPG
 	select ARM_GIC
-- 
1.8.2.1
