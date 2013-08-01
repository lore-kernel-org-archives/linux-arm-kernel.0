From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Aug 2013 17:07:35 +0200
Subject: [PATCHv2 9/9] ARM: kirkwood: update defconfig after DT conversions
In-Reply-To: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375369655-1310-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/kirkwood_defconfig | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index b180588..6d468cb 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -9,27 +9,20 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_KIRKWOOD=y
-CONFIG_MACH_D2NET_V2=y
 CONFIG_MACH_DB88F6281_BP=y
-CONFIG_MACH_DOCKSTAR=y
-CONFIG_MACH_ESATA_SHEEVAPLUG=y
-CONFIG_MACH_GURUPLUG=y
-CONFIG_MACH_INETSPACE_V2=y
-CONFIG_MACH_MV88F6281GTW_GE=y
-CONFIG_MACH_NET2BIG_V2=y
-CONFIG_MACH_NET5BIG_V2=y
-CONFIG_MACH_NETSPACE_MAX_V2=y
-CONFIG_MACH_NETSPACE_V2=y
 CONFIG_MACH_OPENRD_BASE=y
 CONFIG_MACH_OPENRD_CLIENT=y
 CONFIG_MACH_OPENRD_ULTIMATE=y
 CONFIG_MACH_RD88F6192_NAS=y
 CONFIG_MACH_RD88F6281=y
-CONFIG_MACH_SHEEVAPLUG=y
 CONFIG_MACH_T5325=y
 CONFIG_MACH_TS219=y
 CONFIG_MACH_TS41X=y
 CONFIG_MACH_DLINK_KIRKWOOD_DT=y
+CONFIG_MACH_DB88F628X_BP_DT=y
+CONFIG_MACH_MV88F6281GTW_GE_DT=y
+CONFIG_MACH_NET2BIG_V2_DT=y
+CONFIG_MACH_NET5BIG_V2_DT=y
 # CONFIG_CPU_FEROCEON_OLD_ID is not set
 CONFIG_PCI_MVEBU=y
 CONFIG_PREEMPT=y
-- 
1.8.1.2
