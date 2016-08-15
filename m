From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 15 Aug 2016 20:18:43 +0200
Subject: [PATCH v2] MAINTAINERS: Switch to kernel.org account for Krzysztof
 Kozlowski
Message-ID: <1471285123-10085-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change my email address to kernel.org account instead of Samsung one.
Also switch Maxim MUIC charger drivers from supported to maintained
mode.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-samsung-soc at vger.kernel.org

---

Changes since v1:
1. Update also mailmap after Joe Perches suggestion.

Affected drivers/subsystems:
1. arch/arm,
2. mfd,
3. power,
4. regulator,
5. clk,
6. rtc,
7. extcon,
8. pinctrl,
9. sound/soc,

However if there are no objections, I can push it through my tree (to
arm-soc folks).
---
 .mailmap    |  1 +
 MAINTAINERS | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2a91c14c80bf..b18912c5121e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -88,6 +88,7 @@ Kay Sievers <kay.sievers@vrfy.org>
 Kenneth W Chen <kenneth.w.chen@intel.com>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
 Koushik <raghavendra.koushik@neterion.com>
+Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 Leonid I Ananiev <leonid.i.ananiev@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 45c98485c3f0..d437e0123bac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1623,7 +1623,7 @@ N:	rockchip
 
 ARM/SAMSUNG EXYNOS ARM ARCHITECTURES
 M:	Kukjin Kim <kgene@kernel.org>
-M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
 S:	Maintained
@@ -7465,9 +7465,9 @@ F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
-M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-pm at vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/power/supply/max14577_charger.c
 F:	drivers/power/supply/max77693_charger.c
 
@@ -7481,7 +7481,7 @@ F:	include/dt-bindings/*/*max77802.h
 
 MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS
 M:	Chanwoo Choi <cw00.choi@samsung.com>
-M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-kernel at vger.kernel.org
 S:	Supported
 F:	drivers/*/max14577*.c
@@ -9258,7 +9258,7 @@ F:	drivers/pinctrl/sh-pfc/
 
 PIN CONTROLLER - SAMSUNG
 M:	Tomasz Figa <tomasz.figa@gmail.com>
-M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
@@ -10189,7 +10189,7 @@ S:	Maintained
 F:	drivers/platform/x86/samsung-laptop.c
 
 SAMSUNG AUDIO (ASoC) DRIVERS
-M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
 M:	Sangbeom Kim <sbkim73@samsung.com>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
@@ -10204,7 +10204,7 @@ F:	drivers/video/fbdev/s3c-fb.c
 
 SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS
 M:	Sangbeom Kim <sbkim73@samsung.com>
-M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-kernel at vger.kernel.org
 L:	linux-samsung-soc at vger.kernel.org
 S:	Supported
-- 
2.7.4
