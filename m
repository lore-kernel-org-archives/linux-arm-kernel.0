From: ping.bai@nxp.com (Bai Ping)
Date: Fri, 13 Apr 2018 16:04:23 +0800
Subject: [PATCH 1/2] arm: imx: select imx6sll pinctrl when imx6sll enabled
Message-ID: <1523606664-21669-1-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

select imx6sll pinctrl driver if imx6sll config is enabled.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8e3a618..cb010a0 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -514,6 +514,7 @@ config SOC_IMX6SL
 
 config SOC_IMX6SLL
 	bool "i.MX6 SoloLiteLite support"
+	select PINCTRL_IMX6SLL
 	select SOC_IMX6
 
 	help
-- 
1.9.1
