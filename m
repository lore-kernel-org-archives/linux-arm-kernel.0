From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed, 18 May 2016 15:40:29 +0000
Subject: [PATCH-V2 5/6] ARM: multi_v7_defconfig: bcm2835: add bcm2835-sdram
 driver
In-Reply-To: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
References: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463586030-2778-6-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

ad the sdram driver of bcm2835 to the list of compiled
modules in multi_v7_defconfig

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9108cc7..bd6d400 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -764,6 +764,7 @@ CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_ARM_TEGRA_DEVFREQ=m
 CONFIG_MEMORY=y
+CONFIG_BCM2835_SDRAM=y
 CONFIG_EXTCON=y
 CONFIG_TI_AEMIF=y
 CONFIG_IIO=y
-- 
2.1.4
