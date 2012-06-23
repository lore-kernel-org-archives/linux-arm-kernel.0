From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sun, 24 Jun 2012 00:18:59 +0200
Subject: [PATCH 1/1] ARM: OMAP: omap2plus_defconfig: Enable EXT4 support
Message-ID: <1340489939-5390-1-git-send-email-javier@dowhile0.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On OMAP boards that includes an SD card slot, an EXT4 partition could
be used to store the root file system. So, the kernel should have
built-in support for EXT4 to be able to mount the VFS root on boot.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9854ff4..f3087cb 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -197,6 +197,7 @@ CONFIG_RTC_DRV_TWL4030=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
 CONFIG_QUOTA=y
 CONFIG_QFMT_V2=y
 CONFIG_MSDOS_FS=y
-- 
1.7.7.6
