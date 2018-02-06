From: baolin.wang@linaro.org (Baolin Wang)
Date: Tue,  6 Feb 2018 18:36:57 +0800
Subject: [PATCH] arm64: Enable SPRD_TIMER
Message-ID: <6fff71482ed7bb63afa46c024638c0a72810ce29.1517913264.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Spreadtrum timer driver for Spreadtrum plaform, which will be used
as tick broadcast device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/Kconfig.platforms |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fbedbd8..3e0bbb0 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -224,6 +224,7 @@ config ARCH_TEGRA
 
 config ARCH_SPRD
 	bool "Spreadtrum SoC platform"
+	select SPRD_TIMER
 	help
 	  Support for Spreadtrum ARM based SoCs
 
-- 
1.7.9.5
