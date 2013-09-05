From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 5 Sep 2013 12:28:00 +0900
Subject: [PATCH v5 5/5] ARM: tegra: support Trusted Foundations by default
In-Reply-To: <1378351680-14696-1-git-send-email-acourbot@nvidia.com>
References: <1378351680-14696-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1378351680-14696-6-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for Trusted Foundations is light and allows the kernel to run on
a wider range of devices, so enable it by default.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 1effb43..90c90d9 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -28,6 +28,7 @@ CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_TEGRA_PCI=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
+CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-- 
1.8.4
