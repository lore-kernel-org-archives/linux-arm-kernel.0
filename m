From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Apr 2018 12:46:35 +0200
Subject: [PATCH] arm64: renesas_defconfig: enable R8A77980 SoC
Message-ID: <20180423104635.18129-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Renesas R-Car V3H (R8A77980) SoC in the ARM64 renesas_defconfig.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on renesas-devel-20180420-v4.17-rc1

Not for upstream merge
---
 arch/arm64/configs/renesas_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/renesas_defconfig b/arch/arm64/configs/renesas_defconfig
index 03fb7c982314..ffc9e864cd82 100644
--- a/arch/arm64/configs/renesas_defconfig
+++ b/arch/arm64/configs/renesas_defconfig
@@ -36,6 +36,7 @@ CONFIG_ARCH_R8A7796=y
 CONFIG_ARCH_R8A77965=y
 CONFIG_ARCH_R8A77970=y
 CONFIG_ARCH_R8A77980=y
+CONFIG_ARCH_R8A77990=y
 CONFIG_ARCH_R8A77995=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
-- 
2.11.0
