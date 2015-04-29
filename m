From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 29 Apr 2015 22:32:23 +0000
Subject: [PATCH V2 2/6] ARM: mxs: select syscon for platform
In-Reply-To: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1430346747-28728-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select syscon for the MXS platform because it's required by the
power subsystem.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/mach-mxs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 8479413..bf04d38 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -17,6 +17,7 @@ config ARCH_MXS
 	depends on ARCH_MULTI_V5
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
+	select MFD_SYSCON
 	select PINCTRL
 	select SOC_BUS
 	select SOC_IMX23
-- 
1.7.9.5
