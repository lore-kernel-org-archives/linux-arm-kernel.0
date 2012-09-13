From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Sep 2012 17:54:16 +0200
Subject: [PATCH v3 3/5] arm: mvebu: use GPIO support now that a driver is
 available
In-Reply-To: <1347551658-24449-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347551658-24449-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347551658-24449-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-mvebu/include/mach/gpio.h |    1 +
 2 files changed, 2 insertions(+)
 create mode 100644 arch/arm/mach-mvebu/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2eb3f6b..d00d1a3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -575,6 +575,7 @@ config ARCH_MVEBU
 	select COMMON_CLK
 	select PLAT_ORION
 	select PINCTRL
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  Support for the Marvell SoC Family with device tree support
 
diff --git a/arch/arm/mach-mvebu/include/mach/gpio.h b/arch/arm/mach-mvebu/include/mach/gpio.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/gpio.h
@@ -0,0 +1 @@
+/* empty */
-- 
1.7.9.5
