From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 27 Feb 2014 22:28:05 +0100
Subject: [PATCH 4/4] ARM: add Marvell Dove and some drivers to multi_v7
 defconfig
In-Reply-To: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1393536486-3827-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With Marvell Dove now being part of the multi_v7 family, add some Dove
specific drivers to multi_v7 defconfig.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ee6982976d66..a1876b2ed4bd 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -10,6 +10,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_XP=y
+CONFIG_MACH_DOVE=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM_MOBILE=y
 CONFIG_ARCH_BERLIN=y
@@ -111,6 +112,7 @@ CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
 CONFIG_SUN4I_EMAC=y
 CONFIG_NET_CALXEDA_XGMAC=y
+CONFIG_MV643XX_ETH=y
 CONFIG_MVNETA=y
 CONFIG_KS8851=y
 CONFIG_R8169=y
@@ -187,6 +189,7 @@ CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_SENSORS_LM90=y
 CONFIG_THERMAL=y
+CONFIG_DOVE_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_CROS_EC=y
@@ -253,6 +256,7 @@ CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
+CONFIG_MMC_SDHCI_DOVE=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_SPEAR=y
 CONFIG_MMC_SDHCI_BCM_KONA=y
-- 
1.8.5.3
