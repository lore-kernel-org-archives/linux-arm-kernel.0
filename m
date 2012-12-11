From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Dec 2012 19:47:44 -0200
Subject: [PATCH 2/2] ARM: imx_v4_v5_defconfig: Let MACH_IMX25_DT be built by
 default
In-Reply-To: <1355262464-25401-1-git-send-email-festevam@gmail.com>
References: <1355262464-25401-1-git-send-email-festevam@gmail.com>
Message-ID: <1355262464-25401-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Let MACH_IMX25_DT be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index ebbfb27..e706a76 100644
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
1.7.9.5
