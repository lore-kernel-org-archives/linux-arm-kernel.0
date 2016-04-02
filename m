From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Sat,  2 Apr 2016 18:25:49 +0200
Subject: [PATCH v3 7/9] ARM: imx_v6_v7_defconfig: add FT5x06 and TSC2004 touch
 support
In-Reply-To: <1459614351-16731-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
 <1459614351-16731-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1459614351-16731-8-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those two touch controllers are used by Boundary Devices platforms.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---

Changes v1 -> v2:
- none
Changes v2 -> v3:
- none

---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 978c5de..49dd816 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -162,7 +162,9 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
+CONFIG_TOUCHSCREEN_EDT_FT5X06=y
 CONFIG_TOUCHSCREEN_MC13783=y
+CONFIG_TOUCHSCREEN_TSC2004=y
 CONFIG_TOUCHSCREEN_TSC2007=y
 CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_TOUCHSCREEN_SX8654=y
-- 
2.7.0
