From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 24 Feb 2014 20:56:27 +0200
Subject: [PATCH] ARM: keystone_defconfig: enable AEMIF/NAND support
Message-ID: <1393268187-15801-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone SoC uses the same NAND driver as Davinci, so enable
Davinci NAND and AEIMF that provides interface for it.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---

Based on
git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
keystone/master

 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 7056ef4..ec9a41d 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -111,6 +111,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PLATRAM=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_UBI=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
@@ -147,6 +148,7 @@ CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_COMMON_CLK_DEBUG=y
 CONFIG_MEMORY=y
+CONFIG_TI_AEMIF=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_MSDOS_FS=y
-- 
1.8.3.2
