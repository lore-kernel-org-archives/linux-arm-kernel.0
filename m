From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 16 Jun 2016 14:23:58 +0900
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: defconfig: Enable r8a7792 SoC
In-Reply-To: <1466054638-11326-1-git-send-email-horms+renesas@verge.net.au>
References: <1466054638-11326-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1466054638-11326-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for r8a7792 SoC in multi_v7_defconfig.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8f857564657f..672bdac2f6a0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -90,6 +90,7 @@ CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
+CONFIG_ARCH_R8A7792=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
-- 
2.1.4
