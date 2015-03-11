From: Chunyan.Zhang@spreadtrum.com (=?gb2312?B?Q2h1bnlhbiBaaGFuZyAo1cW0utHeKQ==?=)
Date: Wed, 11 Mar 2015 02:27:08 +0000
Subject: [PATCH v8 2/2] arm64: Add support for Spreadtrum's Sharkl64
 Platform in Kconfig and defconfig
In-Reply-To: <1426040790-19495-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1426040790-19495-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <1426040790-19495-3-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>

Adds support for Spreadtrum's SoC Platform in the arm64 Kconfig and
defconfig files.

Signed-off-by: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm64/Kconfig           | 5 +++++
 arch/arm64/configs/defconfig | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e973..e582fe2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -208,6 +208,11 @@ config ARCH_TEGRA_132_SOC
 	  but contains an NVIDIA Denver CPU complex in place of
 	  Tegra124's "4+1" Cortex-A15 CPU complex.
 
+config ARCH_SPRD
+	bool "Spreadtrum SoC platform"
+	help
+	  Support for Spreadtrum ARM based SoCs
+
 config ARCH_THUNDER
 	bool "Cavium Inc. Thunder SoC Family"
 	help
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index be1f12a..535307c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -33,6 +33,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_MEDIATEK=y
+CONFIG_ARCH_SPRD=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
-- 
1.9.1
