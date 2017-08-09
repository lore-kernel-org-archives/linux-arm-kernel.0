From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:18:50 +0800
Subject: [PATCH] arm64: select PINCTRL for ZTE platform
Message-ID: <1502259530-4920-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Select PINCTRL for ZTE platform, so that we can have ZX pinctrl driver
options available for enabling.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index f5f0c813dfec..b65a7e876a26 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -250,6 +250,7 @@ config ARCH_XGENE
 
 config ARCH_ZX
 	bool "ZTE ZX SoC Family"
+	select PINCTRL
 	help
 	  This enables support for ZTE ZX SoC Family
 
-- 
1.9.1
