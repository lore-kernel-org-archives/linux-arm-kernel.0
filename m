From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:38 +0200
Subject: [PATCH 016/102] arm64: dts: renesas: Add Renesas R8A77990 Kconfig
 support
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <c4e96f74ad46d1139e1f31ec925c5bb21aa9830e.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add configuration option for the R-Car E3 (R8A77990) SoC.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 2b1535cdeb7c..d5aeac351fc3 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -208,6 +208,12 @@ config ARCH_R8A77980
 	help
 	  This enables support for the Renesas R-Car V3H SoC.
 
+config ARCH_R8A77990
+	bool "Renesas R-Car E3 SoC Platform"
+	depends on ARCH_RENESAS
+	help
+	  This enables support for the Renesas R-Car E3 SoC.
+
 config ARCH_R8A77995
 	bool "Renesas R-Car D3 SoC Platform"
 	depends on ARCH_RENESAS
-- 
2.11.0
