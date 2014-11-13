From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 11:11:29 +0100
Subject: [PATCH] ARM: mvebu: add MTD_BLOCK to mvebu_v7_defconfig
Message-ID: <1415873489-22446-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since many (most?) mvebu platforms have NAND or SPI flashes, it makes
sense to have CONFIG_MTD_BLOCK=y in mvebu_v7_defconfig. The vast
majority of the other ARM defconfigs have it enabled, including
mvebu_v5_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Patch based on mvebu/defconfig

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 9ca7e78..802c3c6 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -45,6 +45,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-- 
2.0.0
