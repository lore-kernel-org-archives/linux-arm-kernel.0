From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 30 Sep 2014 10:00:34 +0800
Subject: [PATCH 1/6] ARM: imx_v6_v7_defconfig: enable USB Ethernet support at
 host mode
In-Reply-To: <1412042439-13977-1-git-send-email-peter.chen@freescale.com>
References: <1412042439-13977-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1412042439-13977-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is for host mode, and are built as modules.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 16cfec4..82dbf1e 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -130,6 +130,11 @@ CONFIG_SMC911X=y
 CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_AT803X_PHY=y
+CONFIG_USB_PEGASUS=m
+CONFIG_USB_RTL8150=m
+CONFIG_USB_RTL8152=m
+CONFIG_USB_USBNET=m
+CONFIG_USB_NET_CDC_EEM=m
 CONFIG_BRCMFMAC=m
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
-- 
1.7.9.5
