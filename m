From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 15:57:04 +0100
Subject: [PATCH 3/4] arm: mvebu: SATA support: mvebu_defconfig update
In-Reply-To: <1353423425-20574-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353423425-20574-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353423425-20574-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig |    2 ++
 arch/arm/configs/mvebu_defconfig    |    3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 159f75f..dbea6f4 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -17,8 +17,10 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_NET=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_HIGHBANK=y
+CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_CALXEDA_XGMAC=y
 CONFIG_SMSC911X=y
diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 3458752..cdec706 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -20,6 +20,9 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_VFP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_SATA_MV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
1.7.9.5
