From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  4 Oct 2016 17:08:25 +0200
Subject: [RFC 07/10] ARM: meson: enable MESON_IRQ_GPIO in Kconfig for meson8
In-Reply-To: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
References: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1475593708-10526-8-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add select MESON_IRQ_GPIO in Kconfig for Amlogic's meson8 and meson8b SoC

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/mach-meson/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index b6e3acc63e14..63157295cd9d 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -21,11 +21,13 @@ config MACH_MESON8
 	bool "Amlogic Meson8 SoCs support"
 	default ARCH_MESON
 	select MESON6_TIMER
+	select MESON_IRQ_GPIO
 
 config MACH_MESON8B
 	bool "Amlogic Meson8b SoCs support"
 	default ARCH_MESON
 	select MESON6_TIMER
 	select COMMON_CLK_MESON8B
+	select MESON_IRQ_GPIO
 
 endif
-- 
2.7.4
