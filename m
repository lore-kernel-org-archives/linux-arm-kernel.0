From: stefan@agner.ch (Stefan Agner)
Date: Wed, 12 Sep 2018 11:32:19 -0700
Subject: [PATCH v2 5/8] dt-bindings: display: add data-enable polarity property
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
Message-ID: <20180912183222.25414-6-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow to specify the data-enable polarity required by a dumb VGA
DAC converting parallel RGB to VGA.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../devicetree/bindings/display/bridge/dumb-vga-dac.txt         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
index 164cbb15f04c..727111ade203 100644
--- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
+++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
@@ -18,6 +18,8 @@ graph bindings specified in Documentation/devicetree/bindings/graph.txt.
 
 Optional properties:
 - vdd-supply: Power supply for DAC
+- de-active: Polarity of the data enable signal. 0 for active low, 1 for
+  active high, unset for system-specific defaults.
 
 Example
 -------
-- 
2.18.0
