From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 15 May 2013 15:37:02 +0200
Subject: [PATCHv4 9/9] arm: kirkwood: update defconfig with PCIe driver and
 board updates
In-Reply-To: <1368625022-25243-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368625022-25243-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1368625022-25243-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the mvebu PCIe driver in kirkwood_defconfig and
updates various options related to Kirkwood boards.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/kirkwood_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index a1d8252..452adec 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -31,6 +31,7 @@ CONFIG_MACH_T5325=y
 CONFIG_MACH_TS219=y
 CONFIG_MACH_TS41X=y
 CONFIG_MACH_CLOUDBOX_DT=y
+CONFIG_MACH_DB88F628X_BP_DT=y
 CONFIG_MACH_DLINK_KIRKWOOD_DT=y
 CONFIG_MACH_DOCKSTAR_DT=y
 CONFIG_MACH_DREAMPLUG_DT=y
@@ -53,6 +54,7 @@ CONFIG_MACH_READYNAS_DT=y
 CONFIG_MACH_TOPKICK_DT=y
 CONFIG_MACH_TS219_DT=y
 # CONFIG_CPU_FEROCEON_OLD_ID is not set
+CONFIG_PCI_MVEBU=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
-- 
1.7.9.5
