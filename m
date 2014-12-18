From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 18 Dec 2014 21:45:23 +0200
Subject: [PATCH 1/3] devicetree: bindings: add Conexant vendor prefix
In-Reply-To: <cover.1418930377.git.baruch@tkos.co.il>
References: <cover.1418930377.git.baruch@tkos.co.il>
Message-ID: <f16ada07bcbcaf1f32897f2577a1c321958a2130.1418930377.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "cnxt" since it once was the stock ticker of Conexant.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a344ec2713a5..de3e75d909b3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -35,6 +35,7 @@ chrp	Common Hardware Reference Platform
 chunghwa	Chunghwa Picture Tubes Ltd.
 cirrus	Cirrus Logic, Inc.
 cnm	Chips&Media, Inc.
+cnxt	Conexant Systems, Inc.
 cortina	Cortina Systems, Inc.
 crystalfontz	Crystalfontz America, Inc.
 dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
-- 
2.1.3
