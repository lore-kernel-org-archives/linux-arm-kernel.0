From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Feb 2014 11:23:38 +0100
Subject: [PATCH v2 09/10] ARM: mvebu: update defconfigs for Armada 375 and 38x
In-Reply-To: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392200619-3141-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the Armada 375 and Armada 38x support in
mvebu_defconfig and multi_v7_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 arch/arm/configs/mvebu_defconfig    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 845bc74..3c32fc9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -9,6 +9,8 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
+CONFIG_MACH_ARMADA_375=y
+CONFIG_MACH_ARMADA_38X=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM_MOBILE=y
diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 0f4511d..5fc24ae 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -10,6 +10,8 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
+CONFIG_MACH_ARMADA_375=y
+CONFIG_MACH_ARMADA_38X=y
 CONFIG_MACH_ARMADA_XP=y
 # CONFIG_CACHE_L2X0 is not set
 # CONFIG_SWP_EMULATE is not set
-- 
1.8.3.2
