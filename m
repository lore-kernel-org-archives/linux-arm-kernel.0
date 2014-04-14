From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 16:34:14 +0200
Subject: [PATCH v2 4/5] ARM: configs: add ahci_mvebu to mvebu_v7_defconfig
In-Reply-To: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397486055-16303-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x platform needs the ahci_mvebu driver enabled
for the AHCI interfaces, so this commit enables the corresponding
Kconfig option in mvebu_v7_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index a34713d..aaa625a 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -36,6 +36,7 @@ CONFIG_CFG80211=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
+CONFIG_AHCI_MVEBU=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
 CONFIG_MVNETA=y
-- 
1.8.3.2
