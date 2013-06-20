From: joelagnel@ti.com (Joel A Fernandes)
Date: Thu, 20 Jun 2013 16:06:42 -0500
Subject: [PATCH v12 06/11] da8xx: config: Enable MMC and FS options
In-Reply-To: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
Message-ID: <1371762407-24544-7-git-send-email-joelagnel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joel A Fernandes <agnel.joel@gmail.com>

Required to get OMAP-L1 EVM access MMC and mount rootfs

Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
---
 arch/arm/configs/da8xx_omapl_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/da8xx_omapl_defconfig b/arch/arm/configs/da8xx_omapl_defconfig
index 7c86813..35919ca 100644
--- a/arch/arm/configs/da8xx_omapl_defconfig
+++ b/arch/arm/configs/da8xx_omapl_defconfig
@@ -104,6 +104,7 @@ CONFIG_SND_DAVINCI_SOC=m
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_XFS_FS=m
 CONFIG_INOTIFY=y
 CONFIG_AUTOFS4_FS=m
@@ -135,3 +136,5 @@ CONFIG_DEBUG_ERRORS=y
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_CCITT=m
 CONFIG_CRC_T10DIF=m
+CONFIG_MMC=y
+CONFIG_MMC_DAVINCI=y
-- 
1.7.9.5
