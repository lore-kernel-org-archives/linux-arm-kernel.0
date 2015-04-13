From: bintian.wang@huawei.com (Bintian Wang)
Date: Mon, 13 Apr 2015 17:17:35 +0800
Subject: [PATCH v2 1/6] arm64: Enable Hisilicon ARMv8 SoC family in Kconfig
 and defconfig
In-Reply-To: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <1428916660-25910-2-git-send-email-bintian.wang@huawei.com>
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
index 1b8e973..64d4d6d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -228,6 +228,11 @@ config ARCH_XGENE
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
+config ARCH_HISI
+	bool "Hisilicon SoC Family"
+	help
+	  This enables support for Hisilicon ARMv8 SoC family
+
 endmenu
 
 menu "Bus support"
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index be1f12a..36ebd9b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -36,6 +36,7 @@ CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
+CONFIG_ARCH_HISI=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_XGENE=y
-- 
1.9.1
