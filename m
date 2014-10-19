From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sun, 19 Oct 2014 13:53:02 +0200
Subject: [PATCH 3/3] ARM: socfpga: enable INOTIFY_USER
In-Reply-To: <1413719582-16014-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1413719582-16014-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1413719582-16014-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The defconfig has every options that are needed to boot a systemd-based
user space apart from INOTIFY_USER.

Enable it.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/configs/socfpga_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 40eaca055c85..f5a6af6a0de9 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -86,7 +86,7 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT3_FS=y
 # CONFIG_DNOTIFY is not set
-# CONFIG_INOTIFY_USER is not set
+CONFIG_INOTIFY_USER=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_NTFS_RW=y
-- 
2.1.1
