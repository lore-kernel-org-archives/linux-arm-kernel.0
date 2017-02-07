From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue,  7 Feb 2017 17:41:14 +0100
Subject: [PATCH 01/10] media: dt-bindings: vpif: fix whitespace errors
In-Reply-To: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1486485683-11427-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/media/ti,da850-vpif.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
index 6d25d7f..9c7510b 100644
--- a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
+++ b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
@@ -30,15 +30,15 @@ I2C-connected TVP5147 decoder:
 
 		port {
 			vpif_ch0: endpoint at 0 {
-				  reg = <0>;
-				  bus-width = <8>;
-				  remote-endpoint = <&composite>;
+				reg = <0>;
+				bus-width = <8>;
+				remote-endpoint = <&composite>;
 			};
 
 			vpif_ch1: endpoint at 1 {
-				  reg = <1>;
-				  bus-width = <8>;
-				  data-shift = <8>;
+				reg = <1>;
+				bus-width = <8>;
+				data-shift = <8>;
 			};
 		};
 	};
-- 
2.9.3
