From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 8 Nov 2018 10:37:47 +0200
Subject: [RFC 2/9] MAINTAINERS: Add entry for sound/soc/ti and update the OMAP
 audio support
In-Reply-To: <20181108083754.1746-1-peter.ujfalusi@ti.com>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
Message-ID: <20181108083754.1746-3-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sound/soc/davinci and omap directories are merged under sound/soc/ti.

Add myself as maintainer and update the OMAP audio support section with the
new path and file names.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 MAINTAINERS | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c7ccff989456..b278142733e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10668,7 +10668,10 @@ M:	Jarkko Nikula <jarkko.nikula@bitmer.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
 L:	linux-omap at vger.kernel.org
 S:	Maintained
-F:	sound/soc/omap/
+F:	sound/soc/ti/omap*
+F:	sound/soc/ti/rx51.c
+F:	sound/soc/ti/n810.c
+F:	sound/soc/ti/sdma-pcm.*
 
 OMAP CLOCK FRAMEWORK SUPPORT
 M:	Paul Walmsley <paul@pwsan.com>
@@ -14692,6 +14695,12 @@ F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 F:	drivers/irqchip/irq-ti-sci-intr.c
 F:	drivers/irqchip/irq-ti-sci-inta.c
 
+Texas Instruments ASoC drivers
+M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
+L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/ti/
+
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media at vger.kernel.org
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
