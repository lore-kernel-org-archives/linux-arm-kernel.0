From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 27 Oct 2012 19:00:49 +0200
Subject: [PATCH] arm: bcm2835: enable proc and sysfs in defconfig
Message-ID: <1351357249-17658-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason, support for proc and sysfs is currently disabled in
the bcm2835_defconfig, even though those filesystems are quite
essential even for very basic Linux userspace. As most defconfig have
them enabled by default, enable them as well in bcm2835_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/bcm2835_defconfig |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 7aea702..74e27f0 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -66,8 +66,6 @@ CONFIG_TTY_PRINTK=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
-# CONFIG_PROC_FS is not set
-# CONFIG_SYSFS is not set
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_PRINTK_TIME=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
-- 
1.7.9.5
