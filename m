From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 23 Feb 2018 09:51:15 +0100
Subject: [PATCH] arm64: defconfig: enable R8A77965 SoC
Message-ID: <20180223085115.13782-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Renesas R-Car M3-W (R8A77965) SoC in the ARM64 defconfig.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ceafd26f0fab..c8b59543f670 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -51,6 +51,7 @@ CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_R8A7795=y
 CONFIG_ARCH_R8A7796=y
+CONFIG_ARCH_R8A77965=y
 CONFIG_ARCH_R8A77970=y
 CONFIG_ARCH_R8A77980=y
 CONFIG_ARCH_R8A77995=y
-- 
2.11.0
