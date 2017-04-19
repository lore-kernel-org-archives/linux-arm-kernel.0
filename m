From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Wed, 19 Apr 2017 15:45:47 +0200
Subject: [PATCH] ARM: configs: Update Aspeed with VMSPLIT_2G
Message-ID: <1492609547-9494-1-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required for the SMC controller mapping windows on the AHB
Bus.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 arch/arm/configs/aspeed_g4_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 8bd9e6a91d41..aa0e942cd64e 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -25,6 +25,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G4=y
+CONFIG_VMSPLIT_2G=y
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_SECCOMP=y
-- 
2.7.4
