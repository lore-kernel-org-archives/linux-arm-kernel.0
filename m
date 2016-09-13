From: jun.nie@linaro.org (Jun Nie)
Date: Tue, 13 Sep 2016 09:42:04 +0800
Subject: [PATCH v5 1/3] arm64: add ZTE ZX SoC family
In-Reply-To: <1473730926-1034-1-git-send-email-jun.nie@linaro.org>
References: <1473730926-1034-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1473730926-1034-2-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces ARCH_ZX to add the support of the ZTE ZX SoC
family for the arm64 architecture.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index be5d824..bc75fd2 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -204,6 +204,11 @@ config ARCH_XGENE
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
+config ARCH_ZX
+	bool "ZTE ZX SoC Family"
+	help
+	  This enables support for ZTE ZX SoC Family
+
 config ARCH_ZYNQMP
 	bool "Xilinx ZynqMP Family"
 	help
-- 
1.9.1
