From: chanho.min@lge.com (Chanho Min)
Date: Mon, 11 Apr 2016 20:54:44 +0900
Subject: [PATCH v3 1/4] arm64: add Kconfig entry for LG1K SoC family
In-Reply-To: <1460375687-2375-1-git-send-email-chanho.min@lge.com>
References: <1460375687-2375-1-git-send-email-chanho.min@lge.com>
Message-ID: <1460375687-2375-2-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces ARCH_LG1K to enable LG Electronics's LG1K SoC
family in Kconfig.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
Changes for v2:
	- None
Changes for v3:
	- None
---
 arch/arm64/Kconfig.platforms |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f6..b002bba 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -141,4 +141,8 @@ config ARCH_ZYNQMP
 	help
 	  This enables support for Xilinx ZynqMP Family
 
+config ARCH_LG1K
+	bool "LG Electronics LG1K SoC Family"
+	help
+	  This enables support for LG Electronics LG1K SoC Family
 endmenu
-- 
1.7.9.5
