From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Tue, 13 Feb 2018 12:21:15 +0530
Subject: [PATCH v3 2/2] dt-bindings: spi: updated usage example for
 spi-rx/tx-bus-width properties
In-Reply-To: <1518504675-26286-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1518504675-26286-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1518504675-26286-3-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updated usage example by adding properties spi-rx-bus-width
and spi-tx-bus-width for slave node binding.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v3:
- None
Changes for v2:
- None

 Documentation/devicetree/bindings/spi/spi-bus.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 1f6e86f..4dbe267 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -101,6 +101,8 @@ SPI example for an MPC5200 SPI bus:
 			compatible = "micrel,ks8995m";
 			spi-max-frequency = <1000000>;
 			reg = <0>;
+			spi-rx-bus-width = 4;
+			spi-tx-bus-width = 4;
 		};
 
 		codec at 1 {
-- 
1.9.1
