From: matt@genesi-usa.com (Matt Sealey)
Date: Wed,  1 Aug 2012 12:49:29 -0500
Subject: [PATCH 2/4] efikamx: remove Genesi Efika MX from the i.MX v6/v7
 defconfig
In-Reply-To: <1343843371-14143-1-git-send-email-matt@genesi-usa.com>
References: <1343843371-14143-1-git-send-email-matt@genesi-usa.com>
Message-ID: <1343843371-14143-3-git-send-email-matt@genesi-usa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to have Efika MX listed in the defconfig if it can't be built.

Signed-off-by: Matt Sealey <matt@genesi-usa.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index b1d3675..0becdbe 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -31,8 +31,6 @@ CONFIG_MACH_IMX51_DT=y
 CONFIG_MACH_MX51_3DS=y
 CONFIG_MACH_EUKREA_CPUIMX51=y
 CONFIG_MACH_EUKREA_CPUIMX51SD=y
-CONFIG_MACH_MX51_EFIKAMX=y
-CONFIG_MACH_MX51_EFIKASB=y
 CONFIG_MACH_IMX53_DT=y
 CONFIG_SOC_IMX6Q=y
 CONFIG_MXC_PWM=y
-- 
1.7.9.5
