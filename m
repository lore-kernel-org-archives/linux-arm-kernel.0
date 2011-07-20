From: tony.lin@freescale.com (Tony Lin)
Date: Wed, 20 Jul 2011 19:08:26 +0800
Subject: [PATCH 7/7] add usb host function to default config
In-Reply-To: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
Message-ID: <1311160106-4898-8-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 arch/arm/configs/mxs_defconfig |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index db2cb7d..0a187a2 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -87,8 +87,14 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 # CONFIG_MFD_SUPPORT is not set
 CONFIG_DISPLAY_SUPPORT=m
+CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+CONFIG_USB_EHCI_MXC=y
 CONFIG_MMC=y
 CONFIG_MMC_MXS=y
 CONFIG_RTC_CLASS=y
-- 
1.7.0.4
