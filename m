From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 20 Jul 2017 12:22:45 +0200
Subject: [PATCH 2/4] ARM: mediatek: dts: Add mt6796 binding
In-Reply-To: <20170720102247.12342-1-matthias.bgg@gmail.com>
References: <20170720102247.12342-1-matthias.bgg@gmail.com>
Message-ID: <20170720102247.12342-2-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

This patch adds the binding for the MT6797 SoC.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index b0d8d3a9d79e..20ada673ab0c 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible should contain:
 	"mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
 	"mediatek,mt6589-wdt": for MT6589
+	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
 
 - reg : Specifies base physical address and size of the registers.
 
-- 
2.12.3
