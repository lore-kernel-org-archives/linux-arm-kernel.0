From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Oct 2012 14:30:48 +0200
Subject: [PATCH V2 3/4] arm: mvebu: adding SATA support: configs update
In-Reply-To: <1351254650-26861-1-git-send-email-gregory.clement@free-electrons.com>
References: <1351254650-26861-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1351254650-26861-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
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
index 7bcf850..76a60b5 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -18,6 +18,9 @@ CONFIG_ZBOOT_ROM_BSS=0x0
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
