From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Dec 2016 13:38:49 +0100
Subject: [RFC PATCH 14/23] arm: update lpd270_defconfig
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1481027938-31831-15-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update lpd270_defconfig against kernel v4.9-rc6.

The changes were obtained by doing:

	$ make lpd270_defconfig
	$ make savedefconfig
	$ diff -u arch/arm/lpd270_defconfig defconfig

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/lpd270_defconfig | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/configs/lpd270_defconfig b/arch/arm/configs/lpd270_defconfig
index a9dd1e9..be58e42 100644
--- a/arch/arm/configs/lpd270_defconfig
+++ b/arch/arm/configs/lpd270_defconfig
@@ -1,4 +1,3 @@
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SLAB=y
@@ -15,15 +14,12 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
-CONFIG_IPV6=y
 # CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET6_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET6_XFRM_MODE_BEET is not set
 # CONFIG_IPV6_SIT is not set
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_REDBOOT_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
@@ -32,7 +28,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
@@ -42,7 +37,6 @@ CONFIG_SERIAL_PXA_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_FB=y
 CONFIG_FB_PXA=y
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
@@ -50,15 +44,13 @@ CONFIG_SND=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
 CONFIG_SND_PXA2XX_AC97=y
 CONFIG_EXT2_FS=y
-CONFIG_INOTIFY=y
 CONFIG_MSDOS_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_LL=y
-- 
1.9.1
