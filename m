From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  2 Feb 2018 10:36:09 +0100
Subject: [PATCH topic/renesas_defconfig] arm64: renesas_defconfig: enable
 R8A77970 SoC
Message-ID: <20180202093609.19306-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Renesas R-Car V3H (R8A77970) SoC in the ARM64 renesas_defconfig.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/renesas_defconfig | 1 +
 1 file changed, 1 insertion(+)

 Based on renesas-devel-20180202-v4.15

 Not for upstream merge

diff --git a/arch/arm64/configs/renesas_defconfig b/arch/arm64/configs/renesas_defconfig
index 3087bba06d3c..386211464efa 100644
--- a/arch/arm64/configs/renesas_defconfig
+++ b/arch/arm64/configs/renesas_defconfig
@@ -34,6 +34,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_R8A7795=y
 CONFIG_ARCH_R8A7796=y
 CONFIG_ARCH_R8A77970=y
+CONFIG_ARCH_R8A77980=y
 CONFIG_ARCH_R8A77995=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
-- 
2.11.0
