From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jul 2018 14:04:22 +0200
Subject: [PATCH 5/5] ARM: multi_v7_defconfig: Enable support for RZN1D-DB
In-Reply-To: <cover.1532346690.git.horms+renesas@verge.net.au>
References: <cover.1532346690.git.horms+renesas@verge.net.au>
Message-ID: <b036e6420b9aed3498cbd0429f12300139cc5a28.1532346690.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Enable support for the Renesas RZN1D-DB Board:
  - RZ/N1D (R9A06G032) base SoC support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7e1c543162c3..874813d7c08e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -98,6 +98,7 @@ CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7792=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
+CONFIG_ARCH_R9A06G032=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_SIRF=y
-- 
2.11.0
