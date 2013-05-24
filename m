From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 24 May 2013 10:41:18 -0500
Subject: [PATCHv4 4/6] ARM: socfpga: Add syscon to be part of socfpga
In-Reply-To: <1369410080-436-1-git-send-email-dinguyen@altera.com>
References: <1369410080-436-1-git-send-email-dinguyen@altera.com>
Message-ID: <1369410080-436-4-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

SOCFPGA has a system manager register block can be accessed by using
the syscon driver.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: <linux@arm.linux.org.uk>
---
 arch/arm/mach-socfpga/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 566e804..07dff6f 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -13,5 +13,6 @@ config ARCH_SOCFPGA
 	select GPIO_PL061 if GPIOLIB
 	select HAVE_ARM_SCU
 	select HAVE_SMP
+	select MFD_SYSCON
 	select SPARSE_IRQ
 	select USE_OF
-- 
1.7.9.5
