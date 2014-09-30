From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 30 Sep 2014 10:00:35 +0800
Subject: [PATCH 2/6] ARM: imx_v6_v7_defconfig: enable usb media feature for
 host mode
In-Reply-To: <1412042439-13977-1-git-send-email-peter.chen@freescale.com>
References: <1412042439-13977-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1412042439-13977-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mainly for usb camera, and are built as modules.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 82dbf1e..8e92749 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -190,6 +190,8 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_RC_SUPPORT=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
+CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=y
 CONFIG_VIDEO_MX3=y
-- 
1.7.9.5
