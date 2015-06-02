From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Jun 2015 10:34:37 +0900
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable shmobile r8a7793/gose
 platform
In-Reply-To: <1433208877-3284-1-git-send-email-horms+renesas@verge.net.au>
References: <1433208877-3284-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1433208877-3284-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 0d6d6984eb71..ffe3346529f9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -72,6 +72,7 @@ CONFIG_ARCH_R8A7740=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
+CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_MARZEN=y
-- 
2.1.4
