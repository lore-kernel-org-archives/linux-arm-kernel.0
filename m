From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Apr 2018 12:45:56 +0200
Subject: [PATCH] arm64: defconfig: enable R8A77990 SoC
Message-ID: <20180423104556.17636-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Renesas R-Car E3 (R8A77990) SoC in the ARM64 defconfig.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on renesas-devel-20180420-v4.17-rc1
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf613761e78..4a47edcc2f91 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -53,6 +53,7 @@ CONFIG_ARCH_R8A7796=y
 CONFIG_ARCH_R8A77965=y
 CONFIG_ARCH_R8A77970=y
 CONFIG_ARCH_R8A77980=y
+CONFIG_ARCH_R8A77990=y
 CONFIG_ARCH_R8A77995=y
 CONFIG_ARCH_STRATIX10=y
 CONFIG_ARCH_TEGRA=y
-- 
2.11.0
