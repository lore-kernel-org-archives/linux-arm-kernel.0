From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:17 +0900
Subject: [PATCH 05/14] ARM: shmobile: Mark all SoCs in shmobile as CPUFreq,
 capable
In-Reply-To: <cover.1403681315.git.horms+renesas@verge.net.au>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
Message-ID: <6596e97e054647fecb016ecb7e1935aa2b7db954.1403681315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <bcousson@baylibre.com>

Mark all SoCs in shmobile as CPUFreq capable
on multiplatform build only.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
[gaku.inami.xw at bp.renesas.com: Move the definition of cpufreq capable]
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index dbd954e..c32fa7c 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -12,6 +12,8 @@ config ARCH_SHMOBILE_MULTI
 	select NO_IOPORT_MAP
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 
 if ARCH_SHMOBILE_MULTI
 
-- 
2.0.0.rc2
