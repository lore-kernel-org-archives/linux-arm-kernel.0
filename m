From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 10 Oct 2011 11:27:53 +0100
Subject: [PATCH] ARM: S3C64XX: Enable TCM support
Message-ID: <1318242473-19037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C64xx CPUs have TCMs so enable the kernel support for it on these
systems.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8e8f239..3de4cc1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -708,6 +708,7 @@ config ARCH_S3C64XX
 	select CPU_V6
 	select ARM_VIC
 	select HAVE_CLK
+	select HAVE_TCM
 	select CLKDEV_LOOKUP
 	select NO_IOPORT
 	select ARCH_USES_GETTIMEOFFSET
-- 
1.7.6.3
