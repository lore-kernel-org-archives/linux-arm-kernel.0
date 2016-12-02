From: ping.bai@nxp.com (Bai Ping)
Date: Fri, 2 Dec 2016 14:39:34 +0800
Subject: [PATCH 11/11] ARM: configs: enable imx6sll support in defconfig
In-Reply-To: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
References: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1480660774-25055-12-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable i.MX6SLL in imx_v6_v7_defconfig.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index cbe7faf..ab8afb3 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -38,6 +38,7 @@ CONFIG_SOC_IMX51=y
 CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
+CONFIG_SOC_IMX6SLL=y
 CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_IMX6UL=y
 CONFIG_SOC_IMX7D=y
-- 
1.9.1
