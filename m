From: bonbons@linux-vserver.org (Bruno =?UTF-8?B?UHLDqW1vbnQ=?=)
Date: Mon, 20 Oct 2014 22:33:26 +0200
Subject: [RFC Patch 3/4] mfd: AXP20x: Add power supply defconfig entries
In-Reply-To: <20141020215954.7f1d5502@neptune.home>
References: <20141020215954.7f1d5502@neptune.home>
Message-ID: <20141020223326.59fcc235@neptune.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


---
 arch/arm/configs/multi_v7_defconfig              |    1 +
 arch/arm/configs/sunxi_defconfig                 |    1 +
 2 files changed, 2 insertions(+), 0 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6e57d12..9737c26 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -228,6 +228,7 @@ CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_BATTERY_SBS=y
 CONFIG_CHARGER_TPS65090=y
+CONFIG_AXP20X_POWER=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_SUN6I=y
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index acf465f..37277af 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -71,6 +71,7 @@ CONFIG_SPI_SUN4I=y
 CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
+CONFIG_AXP20X_POWER=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SUN6I=y
 # CONFIG_HWMON is not set
