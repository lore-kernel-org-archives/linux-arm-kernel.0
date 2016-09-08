From: netz.kernel@gmail.com (Marty Plummer)
Date: Thu,  8 Sep 2016 12:23:43 -0500
Subject: [RFC 4/7] Make Hi3620 explicit, remove wildcards
In-Reply-To: <20160908172346.27506-1-netz.kernel@gmail.com>
References: <20160908172346.27506-1-netz.kernel@gmail.com>
Message-ID: <20160908172346.27506-4-netz.kernel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a preparatory series for adding the ARMv5/v6 hi3520 SoCs.
Assumptions were made when adding hi3620 that don't hold water in
light of adding support for the hi3520 SoC.  Fix the issue by renaming
config options and other namespaces to avoid collisions with the new
work.

Only internal APIs are modified with this series.

Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2c8665c..a63865e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -45,7 +45,7 @@ CONFIG_MACH_BERLIN_BG2Q=y
 CONFIG_ARCH_DIGICOLOR=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HISI=y
-CONFIG_ARCH_HI3xxx=y
+CONFIG_ARCH_HI3620=y
 CONFIG_ARCH_HIX5HD2=y
 CONFIG_ARCH_HIP01=y
 CONFIG_ARCH_HIP04=y
-- 
2.9.3
