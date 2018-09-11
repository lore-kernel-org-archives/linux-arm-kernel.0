From: mjourdan@baylibre.com (Maxime Jourdan)
Date: Tue, 11 Sep 2018 17:09:38 +0200
Subject: [PATCH v2 3/3] MAINTAINERS: Add meson video decoder
In-Reply-To: <20180911150938.3844-1-mjourdan@baylibre.com>
References: <20180911150938.3844-1-mjourdan@baylibre.com>
Message-ID: <20180911150938.3844-4-mjourdan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry for the meson video decoder for amlogic SoCs.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb57c887..ee086fcff146 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9491,6 +9491,14 @@ F:	drivers/media/platform/meson/ao-cec.c
 F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
 T:	git git://linuxtv.org/media_tree.git
 
+MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS
+M:	Maxime Jourdan <mjourdan@baylibre.com>
+L:	linux-media at lists.freedesktop.org
+L:	linux-amlogic at lists.infradead.org
+S:	Supported
+F:	drivers/media/platform/meson/vdec/
+T:	git git://linuxtv.org/media_tree.git
+
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
 W:	http://www.monstr.eu/fdt/
-- 
2.18.0
