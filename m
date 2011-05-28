From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 28 May 2011 11:11:34 -0300
Subject: [PATCH] mx51: Let USB Storage be built by default
Message-ID: <1306591894-26306-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let USB Storage be built by default. 

Also select NLS_ISO8859 so that the USB device can be mounted.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mx51_defconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mx51_defconfig b/arch/arm/configs/mx51_defconfig
index 0ace16c..88c5802 100644
--- a/arch/arm/configs/mx51_defconfig
+++ b/arch/arm/configs/mx51_defconfig
@@ -106,6 +106,7 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
+CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK=m
 CONFIG_MMC_SDHCI=m
@@ -145,7 +146,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_DEFAULT="cp437"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
-CONFIG_NLS_ISO8859_1=m
+CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
 CONFIG_MAGIC_SYSRQ=y
-- 
1.6.0.4
