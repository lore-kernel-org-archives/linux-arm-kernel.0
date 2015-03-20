From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Mar 2015 10:07:26 +0900
Subject: [PATCH 1/4] ARM: shmobile: Enable ape6evm board in multiplatform
 defconfig
In-Reply-To: <cover.1426813316.git.horms+renesas@verge.net.au>
References: <cover.1426813316.git.horms+renesas@verge.net.au>
Message-ID: <aa01bf614842e774b093f4f02cbc0d473f479e7c.1426813316.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b170360..21851f8 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -12,6 +12,7 @@ CONFIG_SLAB=y
 CONFIG_ARCH_SHMOBILE_MULTI=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_ARCH_R7S72100=y
+CONFIG_ARCH_R8A73A4=y
 CONFIG_ARCH_R8A7740=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
@@ -121,6 +122,7 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_AS3711=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_MAX8973=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
-- 
2.1.4
