From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 10 Oct 2013 16:16:29 +0900
Subject: [PATCH 04/11] ARM: shmobile: marzen: Do not disable
 CONFIG_INOTIFY_USER in defconfig
In-Reply-To: <1381389396-22000-1-git-send-email-horms+renesas@verge.net.au>
References: <1381389396-22000-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1381389396-22000-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_INOTIFY_USER is required for udev to function.
This change brings the marzen defconfig into line with
other shmobile defconfigs.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 96391fc..5d0fa5f 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -106,7 +106,6 @@ CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
-# CONFIG_INOTIFY_USER is not set
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
-- 
1.8.4
