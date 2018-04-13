From: ping.bai@nxp.com (Bai Ping)
Date: Fri, 13 Apr 2018 16:04:24 +0800
Subject: [PATCH 2/2] arm: imx_v6_v7_defconfig: enable imx6sll by default
In-Reply-To: <1523606664-21669-1-git-send-email-ping.bai@nxp.com>
References: <1523606664-21669-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1523606664-21669-2-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable i.mx6sll support by default in defconfig.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4cb9829..50b9d34 100644
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
