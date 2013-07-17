From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 17 Jul 2013 18:10:20 -0500
Subject: [PATCH 1/4] arm: socfpga: Enable ARM_TWD for socfpga
In-Reply-To: <1374102623-4154-1-git-send-email-dinguyen@altera.com>
References: <1374102623-4154-1-git-send-email-dinguyen@altera.com>
Message-ID: <1374102623-4154-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Update Kconfig to enable TWD.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Jack Mitchell <jack.mitchell@dbbroadcast.co.uk>
---
 arch/arm/mach-socfpga/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index dd86db4..efad818 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -11,6 +11,7 @@ config ARCH_SOCFPGA
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PL061 if GPIOLIB
 	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD if LOCAL_TIMERS
 	select HAVE_SMP
 	select MFD_SYSCON
 	select SPARSE_IRQ
-- 
1.7.9.5
