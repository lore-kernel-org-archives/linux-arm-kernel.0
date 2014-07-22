From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 10:39:45 +0100
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable MiPHY365x - ST's Generic
 (SATA & PCIe) PHY
In-Reply-To: <1406021985-8763-1-git-send-email-lee.jones@linaro.org>
References: <1406021985-8763-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406021985-8763-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1a695a5..055949c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -369,6 +369,7 @@ CONFIG_PWM=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
 CONFIG_OMAP_USB2=y
+CONFIG_PHY_MIPHY365X=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
-- 
1.8.3.2
