From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 13 Apr 2013 16:56:45 +0200
Subject: [PATCHv3 10/10] arm: kirkwood: update defconfig with PCIe driver and
 board updates
In-Reply-To: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1365865005-26653-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the mvebu PCIe driver in kirkwood_defconfig and
updates various options related to Kirkwood boards.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/kirkwood_defconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 13482ea..c5275ea 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -10,13 +10,13 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_KIRKWOOD=y
-CONFIG_MACH_DB88F6281_BP=y
 CONFIG_MACH_RD88F6192_NAS=y
 CONFIG_MACH_RD88F6281=y
 CONFIG_MACH_MV88F6281GTW_GE=y
 CONFIG_MACH_SHEEVAPLUG=y
 CONFIG_MACH_ESATA_SHEEVAPLUG=y
-CONFIG_MACH_GURUPLUG=y
+CONFIG_MACH_DB88F6281_BP_DT=y
+CONFIG_MACH_GURUPLUG_DT=y
 CONFIG_MACH_DREAMPLUG_DT=y
 CONFIG_MACH_ICONNECT_DT=y
 CONFIG_MACH_DLINK_KIRKWOOD_DT=y
@@ -48,8 +48,8 @@ CONFIG_MACH_D2NET_V2=y
 CONFIG_MACH_NET2BIG_V2=y
 CONFIG_MACH_NET5BIG_V2=y
 CONFIG_MACH_T5325=y
-CONFIG_MACH_NSA310_DT=y
 # CONFIG_CPU_FEROCEON_OLD_ID is not set
+CONFIG_PCI_MVEBU=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
-- 
1.7.9.5
