From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 16 Sep 2014 10:57:45 +0900
Subject: [PATCH] ARM: shmobile: Enable r8a7794 SoC in shmobile_defconfig
In-Reply-To: <cover.1410832469.git.horms+renesas@verge.net.au>
References: <cover.1410832469.git.horms+renesas@verge.net.au>
Message-ID: <7d984c95723725d26f3961c1655c20256f0affdf.1410832469.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for the r8a7794 was recently added.
Enable it in the shmobile_defconfig to increase build coverage.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 522275a..d7346ad 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -16,6 +16,7 @@ CONFIG_ARCH_R8A7740=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
+CONFIG_ARCH_R8A7794=y
 CONFIG_MACH_KOELSCH=y
 CONFIG_MACH_LAGER=y
 CONFIG_MACH_MARZEN=y
-- 
2.0.1
