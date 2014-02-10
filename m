From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 10 Feb 2014 20:00:36 -0300
Subject: [PATCH v7 17/18] ARM: mvebu: Enable watchdog support in defconfig
In-Reply-To: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1392073237-2554-18-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have proper support for Armada 370/XP watchdog
let's enable it in mvebu_defconfig and multi_v7_defconfig.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 arch/arm/configs/mvebu_defconfig    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 845bc74..51cee83 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -187,6 +187,8 @@ CONFIG_POWER_RESET_GPIO=y
 CONFIG_SENSORS_LM90=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_ORION_WATCHDOG=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 0f4511d..31bdc6f 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -62,6 +62,8 @@ CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_ORION_WATCHDOG=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.8.1.5
