From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:59:33 +0900
Subject: [PATCH 9/9] ARM: shmobile: r8a7778: correct model name in Kconfig
In-Reply-To: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
References: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369648773-7941-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The correct model name is R-Car M1A or R8A77781; R8A77780 corresponds to R-Car
M1S which is a SH based SoC.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[horms+renesas at verge.net.au: manually applied to soc-r8a7778 branch]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 06da4d3..58eb689 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -36,7 +36,7 @@ config ARCH_R8A7740
 	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7778
-	bool "R-Car M1 (R8A77780)"
+	bool "R-Car M1A (R8A77781)"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CPU_V7
 	select SH_CLK_CPG
-- 
1.7.10.4
