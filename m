From: acourbot@nvidia.com (Alexandre Courbot)
Date: Sun, 24 Nov 2013 15:30:52 +0900
Subject: [PATCH v11 7/7] ARM: tegra: support Trusted Foundations by default
In-Reply-To: <1385274652-16415-1-git-send-email-acourbot@nvidia.com>
References: <1385274652-16415-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1385274652-16415-8-git-send-email-acourbot@nvidia.com>
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
index 4934295..da753e3 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -33,6 +33,7 @@ CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIEPORTBUS=y
+CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-- 
1.8.4.2
