From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 23 Sep 2017 00:36:25 +0300
Subject: [PATCH] arm64: defconfig: enable R8A77970 SoC
Message-ID: <20170922213634.084486879@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Renesas R-Car V3M (R8A77970) SoC in the ARM64 defconfig.

Suggested-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the ARM64 repo's 'for-next/core' branch plus the patch
enabling R8A77995 SoC (https://patchwork.kernel.org/patch/9905747/).

 arch/arm64/configs/defconfig |    1 +
 1 file changed, 1 insertion(+)

Index: linux/arch/arm64/configs/defconfig
===================================================================
--- linux.orig/arch/arm64/configs/defconfig
+++ linux/arch/arm64/configs/defconfig
@@ -50,6 +50,7 @@ CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_R8A7795=y
 CONFIG_ARCH_R8A7796=y
+CONFIG_ARCH_R8A77970=y
 CONFIG_ARCH_R8A77995=y
 CONFIG_ARCH_STRATIX10=y
 CONFIG_ARCH_TEGRA=y
