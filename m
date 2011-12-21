From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 21 Dec 2011 17:37:41 -0200
Subject: [PATCH] ARM: mx3_defconfig: Allow all the targets to be built by
 default
Message-ID: <1324496261-30844-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to get better build coverage, include the two missing platforms to be build
by default on mx3_defconfig.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mx3_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
index cb0717f..a2550fa 100644
--- a/arch/arm/configs/mx3_defconfig
+++ b/arch/arm/configs/mx3_defconfig
@@ -24,6 +24,8 @@ CONFIG_MACH_KZM_ARM11_01=y
 CONFIG_MACH_PCM043=y
 CONFIG_MACH_MX35_3DS=y
 CONFIG_MACH_EUKREA_CPUIMX35=y
+CONFIG_MACH_VPR200=y
+CONFIG_SOC_IMX6Q=y
 CONFIG_MXC_IRQ_PRIOR=y
 CONFIG_MXC_PWM=y
 CONFIG_ARM_ERRATA_411920=y
-- 
1.7.1
