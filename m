From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 22 Feb 2017 14:43:45 +0100
Subject: [PATCH v2 1/3] media: dt-bindings: vpif: fix whitespace errors
In-Reply-To: <1487771027-7763-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487771027-7763-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487771027-7763-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The examples have been copied from the DT with whitespace errors. Fix
them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
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
