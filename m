From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Feb 2017 04:34:38 +0100
Subject: [PATCH 3/4] ARM64: Prepare Realtek RTD1295
In-Reply-To: <20170214033440.18667-1-afaerber@suse.de>
References: <20170214033440.18667-1-afaerber@suse.de>
Message-ID: <20170214033440.18667-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Kconfig option ARCH_REALTEK.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 129cc5a..2fa9557 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -118,6 +118,12 @@ config ARCH_QCOM
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
+config ARCH_REALTEK
+	bool "Realtek Platforms"
+	help
+	  This enables support for the ARMv8 based Realtek chipsets,
+	  like the RTD1295.
+
 config ARCH_ROCKCHIP
 	bool "Rockchip Platforms"
 	select ARCH_HAS_RESET_CONTROLLER
-- 
2.10.2
