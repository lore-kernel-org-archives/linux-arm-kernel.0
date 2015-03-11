From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Mar 2015 09:43:55 -0300
Subject: [PATCH 7/7] ARM: imx_v4_v5_defconfig: Remove CONFIG_MACH_MX25_3DS
In-Reply-To: <1426077835-31081-1-git-send-email-festevam@gmail.com>
References: <1426077835-31081-1-git-send-email-festevam@gmail.com>
Message-ID: <1426077835-31081-7-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

We do not have CONFIG_MACH_MX25_3DS platform anymore, so update the defconfig.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index b959617..af07e05 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -24,7 +24,6 @@ CONFIG_ARCH_MXC=y
 CONFIG_MACH_SCB9328=y
 CONFIG_MACH_APF9328=y
 CONFIG_MACH_MX21ADS=y
-CONFIG_MACH_MX25_3DS=y
 CONFIG_MACH_EUKREA_CPUIMX25SD=y
 CONFIG_SOC_IMX25=y
 CONFIG_MACH_MX27ADS=y
-- 
1.9.1
