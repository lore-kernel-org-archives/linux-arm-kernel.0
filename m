From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 23 Feb 2018 09:51:57 +0100
Subject: [PATCH] arm64: renesas_defconfig: enable R8A77965 SoC
Message-ID: <20180223085157.13876-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Renesas R-Car M3-W (R8A77965) SoC in the ARM64 renesas_defconfig.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/renesas_defconfig | 1 +
 1 file changed, 1 insertion(+)

  Not for upstream merge

diff --git a/arch/arm64/configs/renesas_defconfig b/arch/arm64/configs/renesas_defconfig
index 386211464efa..03fb7c982314 100644
--- a/arch/arm64/configs/renesas_defconfig
+++ b/arch/arm64/configs/renesas_defconfig
@@ -33,6 +33,7 @@ CONFIG_BLK_DEV_INTEGRITY=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_R8A7795=y
 CONFIG_ARCH_R8A7796=y
+CONFIG_ARCH_R8A77965=y
 CONFIG_ARCH_R8A77970=y
 CONFIG_ARCH_R8A77980=y
 CONFIG_ARCH_R8A77995=y
-- 
2.11.0
