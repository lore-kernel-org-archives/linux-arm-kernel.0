From: bintian.wang@huawei.com (Bintian Wang)
Date: Mon, 13 Apr 2015 17:17:39 +0800
Subject: [PATCH v2 5/6] arm64: Kconfig: Add clock support to ARCH_HISI
In-Reply-To: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <1428916660-25910-6-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select hi6220 clock driver for ARCH_HISI.

Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 64d4d6d..75c55fe 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -230,6 +230,7 @@ config ARCH_XGENE
 
 config ARCH_HISI
 	bool "Hisilicon SoC Family"
+	select COMMON_CLK_HI6220
 	help
 	  This enables support for Hisilicon ARMv8 SoC family
 
-- 
1.9.1
