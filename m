From: chanho.min@lge.com (Chanho Min)
Date: Mon, 7 Mar 2016 13:09:57 +0900
Subject: [PATCH 1/4] arm64: add Kconfig entry for LG1K SoC family
In-Reply-To: <1457323800-26904-1-git-send-email-chanho.min@lge.com>
References: <1457323800-26904-1-git-send-email-chanho.min@lge.com>
Message-ID: <1457323800-26904-2-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces ARCH_LG1K to enable LG Electronics's LG1K SoC
family in Kconfig.

Signed-off-by: Chanho Min <chanho.min@lge.com>
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
