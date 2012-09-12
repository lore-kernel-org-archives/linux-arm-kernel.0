From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Sep 2012 12:48:53 +0200
Subject: [PATCH 2/2] arm: mvebu: select the pinctrl drivers for Armada
 370 and Armada XP platforms
In-Reply-To: <504F7798.6070501@gmail.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347377834-19402-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1347377834-19402-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <504F7798.6070501@gmail.com>
Message-ID: <20120912124853.42cc418f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 11 Sep 2012 19:40:40 +0200,
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> a ?crit :

> Using PINCTRL_MVEBU on any mvebu SoC requires to
> "select PINCTRL" in arch/arm/Kconfig for ARCH_MVEBU, too.

This is already done by your PATCH 1/9 from the v3 of your patchset:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a2b6f74..2eb3f6b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -574,6 +574,7 @@ config ARCH_MVEBU
 	select IRQ_DOMAIN
 	select COMMON_CLK
 	select PLAT_ORION
+	select PINCTRL
 	help
 	  Support for the Marvell SoC Family with device tree support

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
