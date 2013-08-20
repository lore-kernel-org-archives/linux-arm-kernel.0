From: fathi.boudra@linaro.org (Fathi Boudra)
Date: Wed, 21 Aug 2013 00:02:43 +0300
Subject: [PATCH 3/3] ARM: vexpress_defconfig: Enable ext4 filesystem
In-Reply-To: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
References: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
Message-ID: <1377032563-4502-4-git-send-email-fathi.boudra@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An ext4 partition could be used to store the root file system.
The kernel need to have built-in support for ext4 to be able to mount
the VFS root on boot.

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
---
 arch/arm/configs/vexpress_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index c2f7ca1..e9ab454 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -119,6 +119,7 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
-- 
1.8.1.2
