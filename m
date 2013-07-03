From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Jul 2013 09:42:57 -0300
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Select CONFIG_MACH_IMX25_DT
Message-ID: <1372855377-19884-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Allow booting a mx25 dt kernel by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index f07a847..dcd3d91 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -27,6 +27,7 @@ CONFIG_MACH_APF9328=y
 CONFIG_MACH_MX21ADS=y
 CONFIG_MACH_MX25_3DS=y
 CONFIG_MACH_EUKREA_CPUIMX25SD=y
+CONFIG_MACH_IMX25_DT=y
 CONFIG_MACH_MX27ADS=y
 CONFIG_MACH_PCM038=y
 CONFIG_MACH_CPUIMX27=y
-- 
1.8.1.2
