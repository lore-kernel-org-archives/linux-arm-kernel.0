From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 24 Jul 2013 17:20:04 -0300
Subject: [PATCH v2 2/2] ARM: imx_v6_v7_defconfig: Select
 CONFIG_TOUCHSCREEN_EGALAX
In-Reply-To: <1374697204-18474-1-git-send-email-fabio.estevam@freescale.com>
References: <1374697204-18474-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1374697204-18474-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

egalax touchscren controller is present on mx6 sabresd/sabrelite, so let's 
enable it by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f1662d3..9e15992 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -127,6 +127,7 @@ CONFIG_KEYBOARD_IMX=y
 CONFIG_MOUSE_PS2=m
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_MC13783=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MMA8450=y
-- 
1.8.1.2
