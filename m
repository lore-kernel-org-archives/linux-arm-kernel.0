From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 27 Aug 2013 20:27:11 +0200
Subject: [PATCH] ASoc: kirkwood: Use the Kirkwood audio driver in Dove boards
Message-ID: <20130827202711.6230c38d@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch permits the generation of the Kirkwood audio driver which
may be used in the Dove boards.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/Kconfig                   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 9e1970c..78ed4a4 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -1,6 +1,6 @@
 config SND_KIRKWOOD_SOC
-	tristate "SoC Audio for the Marvell Kirkwood chip"
-	depends on ARCH_KIRKWOOD || COMPILE_TEST
+	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
+	depends on ARCH_KIRKWOOD || ARCH_DOVE || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Kirkwood I2S interface. You will also need to select the


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
