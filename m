From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:07 +0100
Subject: [PATCH 37/69] arm64: add Renesas R8A77965 support
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <fd60ea3171c7429a37c5b47a9893f96c704f990d.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add configuration option for the R-Car M3-N (R8A77965) SoC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b51db26f6eaa..2b1535cdeb7c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -190,6 +190,12 @@ config ARCH_R8A7796
 	help
 	  This enables support for the Renesas R-Car M3-W SoC.
 
+config ARCH_R8A77965
+	bool "Renesas R-Car M3-N SoC Platform"
+	depends on ARCH_RENESAS
+	help
+	  This enables support for the Renesas R-Car M3-N SoC.
+
 config ARCH_R8A77970
 	bool "Renesas R-Car V3M SoC Platform"
 	depends on ARCH_RENESAS
-- 
2.11.0
