From: denis@eukrea.com (Denis Carikli)
Date: Wed, 27 Nov 2013 16:39:31 +0100
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Enable mc13xxx-pwm support.
In-Reply-To: <1385566771-366-1-git-send-email-denis@eukrea.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
Message-ID: <1385566771-366-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eukrea mbimx53sd has its display backlighgt
  connected to the pwm of its mc13xxx, so we turn
  it on.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree at vger.kernel.org
Cc: linux-pwm at vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index d479049..4bd1b13 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -241,6 +241,7 @@ CONFIG_COMMON_CLK_DEBUG=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PWM=y
 CONFIG_PWM_IMX=y
+CONFIG_PWM_MC13XXX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
1.7.9.5
