From: jun.nie@linaro.org (Jun Nie)
Date: Tue, 16 Aug 2016 16:22:14 +0800
Subject: [PATCH 3/3] arm64: defconfig: enable ZTE ZX related config
In-Reply-To: <1471335734-26893-1-git-send-email-jun.nie@linaro.org>
References: <1471335734-26893-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1471335734-26893-3-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the configuration for the ZTE ZX family.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0555b7c..060b796 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -54,6 +54,7 @@ CONFIG_ARCH_UNIPHIER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VULCAN=y
 CONFIG_ARCH_XGENE=y
+CONFIG_ARCH_ZX=y
 CONFIG_ARCH_ZYNQMP=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
-- 
1.9.1
