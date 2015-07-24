From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:44:48 +0900
Subject: [PATCH 2/5] ARM: multi_v7_defconfig: Enable shmobile r8a7793/gose
 platform
In-Reply-To: <cover.1437727455.git.horms+renesas@verge.net.au>
References: <cover.1437727455.git.horms+renesas@verge.net.au>
Message-ID: <dbeb9728d4b9785fc78336038654eb2bac155d92.1437727455.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6d83a1bf0c74..77f4b76d16e9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -80,6 +80,7 @@ CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
+CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_MARZEN=y
-- 
2.1.4
