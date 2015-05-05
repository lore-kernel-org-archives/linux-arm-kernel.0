From: bintian.wang@huawei.com (Bintian Wang)
Date: Tue, 5 May 2015 12:30:08 +0800
Subject: [PATCH v3 1/5] arm64: Enable Hisilicon ARMv8 SoC family in Kconfig
 and defconfig
In-Reply-To: <1430800212-6970-1-git-send-email-bintian.wang@huawei.com>
References: <1430800212-6970-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <1430800212-6970-2-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces ARCH_HISI to enable Hisilicon SoC family in
Kconfig and defconfig.

Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
Reviewed-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Reviewed-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm64/Kconfig           | 5 +++++
 arch/arm64/configs/defconfig | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4269dba..2af5efe 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -180,6 +180,11 @@ config ARCH_FSL_LS2085A
 	help
 	  This enables support for Freescale LS2085A SOC.
 
+config ARCH_HISI
+	bool "Hisilicon SoC Family"
+	help
+	  This enables support for Hisilicon ARMv8 SoC family
+
 config ARCH_MEDIATEK
 	bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
 	select ARM_GIC
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2ed7449..1d293ea 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -33,6 +33,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_ARCH_EXYNOS7=y
 CONFIG_ARCH_FSL_LS2085A=y
+CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_TEGRA=y
-- 
1.9.1
