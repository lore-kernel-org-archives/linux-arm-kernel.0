From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 20 Jul 2017 14:29:01 +0200
Subject: [PATCH 3/3] arm64: renesas: Add Renesas R8A77995 Kconfig support
In-Reply-To: <1500553741-21890-1-git-send-email-geert+renesas@glider.be>
References: <1500553741-21890-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1500553741-21890-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a configuration option for the R-Car D3 SoC.

Note that r8a77995 is the first Renesas "r8a<n>" SoC using a 5 digit
number in its Kconfig symbol, as r8a77990 will be a different SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index f5f0c813dfecc56c..a1c9f4ed7a887ab2 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -184,6 +184,12 @@ config ARCH_R8A7796
 	help
 	  This enables support for the Renesas R-Car M3-W SoC.
 
+config ARCH_R8A77995
+	bool "Renesas R-Car D3 SoC Platform"
+	depends on ARCH_RENESAS
+	help
+	  This enables support for the Renesas R-Car D3 SoC.
+
 config ARCH_STRATIX10
 	bool "Altera's Stratix 10 SoCFPGA Family"
 	help
-- 
2.7.4
