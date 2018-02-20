From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 20 Feb 2018 16:12:09 +0100
Subject: [PATCH v2 07/19] ARM64: Add Renesas R-Car M3-N config symbol
In-Reply-To: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1519139541-18783-8-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add configuration option for the R-Car M3-N (R8A77965) SoC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b51db26..2b1535c 100644
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
2.7.4
