From: stefan@agner.ch (Stefan Agner)
Date: Sun, 18 Mar 2018 21:15:09 +0100
Subject: [PATCH 2/3] ARM: imx_v6_v7_defconfig: add mwifiex driver
In-Reply-To: <20180318201510.13086-1-stefan@agner.ch>
References: <20180318201510.13086-1-stefan@agner.ch>
Message-ID: <20180318201510.13086-2-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Marvell mwifiex driver which is required to drive the
Wi2Wi WM828CC6 wireless module found on Colibri iMX6ULL.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8947769cd449..67db78f8c9df 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -153,6 +153,9 @@ CONFIG_USB_RTL8152=m
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_CDC_EEM=m
 CONFIG_BRCMFMAC=m
+CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
+CONFIG_MWIFIEX_PCIE=m
 CONFIG_WL12XX=m
 CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
-- 
2.16.2
