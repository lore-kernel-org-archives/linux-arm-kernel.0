From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 22 Nov 2012 17:10:44 -0200
Subject: [PATCH 2/4] ARM: Let CONFIG_MACH_IMX31_DT be built by default
In-Reply-To: <1353611447-7732-1-git-send-email-fabio.estevam@freescale.com>
References: <1353611447-7732-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1353611447-7732-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let CONFIG_MACH_IMX31_DT be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 44f117a..02dba2c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -19,6 +19,7 @@ CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_ARCH_MXC=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_MULTI_V7=y
+CONFIG_MACH_IMX31_DT=y
 CONFIG_MACH_MX31LILLY=y
 CONFIG_MACH_MX31LITE=y
 CONFIG_MACH_PCM037=y
-- 
1.7.9.5
