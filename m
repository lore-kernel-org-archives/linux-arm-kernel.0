From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 29 Aug 2018 16:31:40 +0200
Subject: [PATCH 04/11] MAINTAINERS: ASoC: change maintainer for Microchip ALSA
 drivers
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
Message-ID: <fd2e6fdc006005e002cabeafa9b8020995281ea1.1535552609.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hand over to Codrin for Microchip Audio SoC drivers in "atmel"
directory.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eaf54960c1c..686822714e6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2482,7 +2482,7 @@ S:	Supported
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
 
 ATMEL Audio ALSA driver
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/atmel
-- 
2.17.1
