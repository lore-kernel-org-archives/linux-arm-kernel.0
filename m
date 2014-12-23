From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 23 Dec 2014 09:58:41 +0200
Subject: [PATCH 4/8] ARM: devicetree: document supported Conexant Digicolor SoC
In-Reply-To: <cover.1419318109.git.baruch@tkos.co.il>
References: <cover.1419318109.git.baruch@tkos.co.il>
Message-ID: <bde46039e9390f0aa49a296bcea28086f03f1002.1419318109.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/devicetree/bindings/arm/digicolor.txt | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/digicolor.txt

diff --git a/Documentation/devicetree/bindings/arm/digicolor.txt b/Documentation/devicetree/bindings/arm/digicolor.txt
new file mode 100644
index 000000000000..658553f40b23
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/digicolor.txt
@@ -0,0 +1,6 @@
+Conexant Digicolor Platforms Device Tree Bindings
+
+Each device tree must specify which Conexant Digicolor SoC it uses.
+Must be the following compatible string:
+
+  cnxt,cx92755
-- 
2.1.3
