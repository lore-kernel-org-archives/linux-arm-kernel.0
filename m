From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 13 Jun 2013 19:51:04 +0800
Subject: [PATCH 9/9] ARM: imx_v6_v7_defconfig: Enable imx-wm8962 by default
In-Reply-To: <cover.1371123426.git.b42378@freescale.com>
References: <cover.1371123426.git.b42378@freescale.com>
Message-ID: <6da90572965178094fcc87c38a122c30a601db28.1371123426.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable imx-wm8962 and PM_RUNTIME, essential for WM8962 CODEC driver.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index ac3470c..b977314 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -48,6 +48,7 @@ CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_BINFMT_MISC=m
+CONFIG_PM_RUNTIME=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_TEST_SUSPEND=y
 CONFIG_NET=y
@@ -183,6 +184,7 @@ CONFIG_SND_SOC=y
 CONFIG_SND_IMX_SOC=y
 CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
+CONFIG_SND_SOC_IMX_WM8962=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_MC13783=y
 CONFIG_USB=y
-- 
1.7.1
