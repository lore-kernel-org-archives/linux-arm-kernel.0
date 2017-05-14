From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 14 May 2017 04:24:27 +0200
Subject: [PATCH v3 3/5] ARM64: Prepare Realtek RTD1295
In-Reply-To: <20170514022429.11555-1-afaerber@suse.de>
References: <20170514022429.11555-1-afaerber@suse.de>
Message-ID: <20170514022429.11555-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Kconfig option ARCH_REALTEK.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2 -> v3: unchanged
 
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 73272f43ca01..b4e919ac73f6 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -126,6 +126,12 @@ config ARCH_QCOM
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
2.12.0
