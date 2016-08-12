From: fabf@skynet.be (Fabian Frederick)
Date: Fri, 12 Aug 2016 23:05:07 +0200
Subject: [RFC linux-next] ARM: clps711x: update defconfig
Message-ID: <1471035907-8856-1-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sync defconfig to commit 4a56f46a7dc6
("ARM: clps711x: Remove boards support")

or maybe we could just remove it ?

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/arm/configs/clps711x_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index fc105c9..64a0ad6 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -10,11 +10,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_CLPS711X=y
-CONFIG_ARCH_AUTCPU12=y
-CONFIG_ARCH_CDB89712=y
-CONFIG_ARCH_CLEP7312=y
-CONFIG_ARCH_EDB7211=y
-CONFIG_ARCH_P720T=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-- 
2.8.1
