From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:44:47 +0900
Subject: [PATCH 1/5] ARM: shmobile: Enable gose board in multiplatform
 defconfig
In-Reply-To: <cover.1437727455.git.horms+renesas@verge.net.au>
References: <cover.1437727455.git.horms+renesas@verge.net.au>
Message-ID: <b059be7ecfa80550f635194f7c12578423177729.1437727455.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 9961fbd633f8..c8e9caeb1c02 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -18,6 +18,7 @@ CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
+CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_MARZEN=y
-- 
2.1.4
