From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 31 Jan 2018 22:59:03 +0300
Subject: [PATCH 2/2] arm64: add Renesas R8A77980 support
In-Reply-To: <fbdd08a3-1ab3-8e70-20f1-d9c41493b11c@cogentembedded.com>
References: <fbdd08a3-1ab3-8e70-20f1-d9c41493b11c@cogentembedded.com>
Message-ID: <4bf1d0e3-7389-cd24-ff6a-c750d8ea42d6@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a configuration option for the R-Car V3H (R8A77980) SoC.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/Kconfig.platforms |    6 ++++++
 1 file changed, 6 insertions(+)

Index: renesas/arch/arm64/Kconfig.platforms
===================================================================
--- renesas.orig/arch/arm64/Kconfig.platforms
+++ renesas/arch/arm64/Kconfig.platforms
@@ -195,6 +195,12 @@ config ARCH_R8A77970
 	help
 	  This enables support for the Renesas R-Car V3M SoC.
 
+config ARCH_R8A77980
+	bool "Renesas R-Car V3H SoC Platform"
+	depends on ARCH_RENESAS
+	help
+	  This enables support for the Renesas R-Car V3H SoC.
+
 config ARCH_R8A77995
 	bool "Renesas R-Car D3 SoC Platform"
 	depends on ARCH_RENESAS
