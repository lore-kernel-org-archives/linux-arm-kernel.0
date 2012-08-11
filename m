From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 11 Aug 2012 14:56:48 +0200
Subject: [PATCH 10/11] arm: mvebu: enable PINCTRL usage
In-Reply-To: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1344689809-6223-11-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Now that we have a proper pinctrl driver for Marvell EBU platforms,
enable PINCTRL support in ARCH_MVEBU.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lior Amsalem <alior@marvell.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 361f513..95317a9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -573,6 +573,7 @@ config ARCH_MVEBU
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select COMMON_CLK
+	select PINCTRL
 	help
 	  Support for the Marvell SoC Family with device tree support
 
-- 
1.7.10.4
