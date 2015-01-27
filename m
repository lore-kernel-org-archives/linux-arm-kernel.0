From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 27 Jan 2015 16:12:47 +0800
Subject: [PATCH v7 2/2] arm64: Add support for Spreadtrum's Sharkl64 Platform
 in Kconfig and defconfig
In-Reply-To: <1422346367-10628-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sc9836-dt-v7>
 <1422346367-10628-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <1422346367-10628-3-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>

Adds support for Spreadtrum's SoC Platform in the arm64 Kconfig and
defconfig files.

Signed-off-by: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm64/Kconfig           |    5 +++++
 arch/arm64/configs/defconfig |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1f9a20..885c1f4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -153,6 +153,11 @@ config ARCH_SEATTLE
 	help
 	  This enables support for AMD Seattle SOC Family
 
+config ARCH_SPRD
+	bool "Spreadtrum SoC platform"
+	help
+	  Support for Spreadtrum ARM based SoCs
+
 config ARCH_THUNDER
 	bool "Cavium Inc. Thunder SoC Family"
 	help
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dd301be..2eb303a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -32,6 +32,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_SPRD=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
-- 
1.7.9.5
