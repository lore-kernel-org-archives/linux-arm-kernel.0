From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:11 +0100
Subject: [PATCH 3/4] ARM: shmobile: defconfig: Enable r8a774[35] SoCs
In-Reply-To: <cover.1483701293.git.horms+renesas@verge.net.au>
References: <cover.1483701293.git.horms+renesas@verge.net.au>
Message-ID: <d234e29dae04b224a63e39bc29938fa77819b3f1.1483701293.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable recently added r8a7743 (RZ/G1M) and r8a7745 (RZ/G1E) SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b66e17aec058..760688aa5c79 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -14,6 +14,8 @@ CONFIG_ARCH_EMEV2=y
 CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A73A4=y
 CONFIG_ARCH_R8A7740=y
+CONFIG_ARCH_R8A7743=y
+CONFIG_ARCH_R8A7745=y
 CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
-- 
2.7.0.rc3.207.g0ac5344
