From: diego.dorta@nxp.com (Diego Dorta)
Date: Wed, 22 Jun 2016 16:37:10 -0300
Subject: [PATCH v2 4/4] ARM: imx_v6_v7_defconfig: Select ADS7846 support
In-Reply-To: <1466624230-16191-1-git-send-email-diego.dorta@nxp.com>
References: <1466624230-16191-1-git-send-email-diego.dorta@nxp.com>
Message-ID: <1466624230-16191-4-git-send-email-diego.dorta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CONFIG_TOUCHSCREEN_ADS7846 support.

Signed-off-by: Diego Dorta <diego.dorta@nxp.com>
---
Changes since v1:
- None.

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4b36039..f5af9c5 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -161,6 +161,7 @@ CONFIG_KEYBOARD_IMX=y
 CONFIG_MOUSE_PS2=m
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_EDT_FT5X06=y
-- 
2.7.4
