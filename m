From: bintian.wang@huawei.com (Bintian Wang)
Date: Thu, 5 Feb 2015 17:24:35 +0800
Subject: [PATCH 1/3] arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and
 defconfig
In-Reply-To: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <1423128277-10297-2-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces ARCH_HISI to enable Hisilicon SoC family in
Kconfig and defconfig.

Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
Reviewed-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Reviewed-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm64/Kconfig           |    5 +++++
 arch/arm64/configs/defconfig |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1f9a20..78cd41c8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -173,6 +173,11 @@ config ARCH_XGENE
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
+config ARCH_HISI
+	bool "Hisilicon SoC Family"
+	help
+	  This enables support for Hisilicon ARMv8 Family of SoCs.
+
 endmenu
 
 menu "Bus support"
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5376d90..a829774 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -34,6 +34,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
+CONFIG_ARCH_HISI=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_XGENE=y
-- 
1.7.9.5
