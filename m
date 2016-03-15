From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue, 15 Mar 2016 15:04:27 +0100
Subject: [PATCH v2 8/9] ARM: imx_v6_v7_defconfig: add CONFIG_I2C_MUX_GPIO
In-Reply-To: <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1458037826-19375-1-git-send-email-gary.bisson@boundarydevices.com>
 <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1458050668-26748-9-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2C muxing is used on Nitrogen6_MAX board from Boundary Devices.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---

Changelog v1 -> v2:
- none

---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 49dd816..1faafe3 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -180,6 +180,7 @@ CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX_GPIO=y
 # CONFIG_I2C_HELPER_AUTO is not set
 CONFIG_I2C_ALGOPCF=m
 CONFIG_I2C_ALGOPCA=m
-- 
2.7.0
