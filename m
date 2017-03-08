From: jagan@openedev.com (Jagan Teki)
Date: Wed,  8 Mar 2017 12:47:57 +0530
Subject: [PATCH v4 7/7] arm: imx_v6_v7_defconfig: Select hid-multitouchdriver
In-Reply-To: <1488957477-5621-1-git-send-email-jagan@openedev.com>
References: <1488957477-5621-1-git-send-email-jagan@openedev.com>
Message-ID: <1488957477-5621-7-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Select CONFIG_HID_MULTITOUCH so that we can have multi touchscreen
funtionality via USB by default on Engicam i.CoreM6 Quad with
OpenFrame Cap 10.1 display boards.

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- Newly added patch.

 arch/arm/boot/dts/imx6q-icore.dts | 9 +++++++++
 1 file changed, 9 insertions(+)
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 842168f..914e8cb 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -174,6 +174,7 @@ CONFIG_TOUCHSCREEN_SX8654=y
 CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MMA8450=y
+CONFIG_HID_MULTITOUCH=y
 CONFIG_SERIO_SERPORT=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_IMX=y
-- 
1.9.1
