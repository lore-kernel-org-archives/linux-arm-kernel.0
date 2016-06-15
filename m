From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 15 Jun 2016 12:01:45 +0200
Subject: [RESEND PATCH 1/2] dt-bindings: hwrng: Add Amlogic Meson Hardware
 Random Generator bindings
In-Reply-To: <1465984906-17840-1-git-send-email-narmstrong@baylibre.com>
References: <1465984906-17840-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1465984906-17840-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/rng/amlogic,meson-rng.txt          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/amlogic,meson-rng.txt

diff --git a/Documentation/devicetree/bindings/rng/amlogic,meson-rng.txt b/Documentation/devicetree/bindings/rng/amlogic,meson-rng.txt
new file mode 100644
index 0000000..202f2d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/amlogic,meson-rng.txt
@@ -0,0 +1,14 @@
+Amlogic Meson Random number generator
+=====================================
+
+Required properties:
+
+- compatible : should be "amlogic,meson-rng"
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+rng {
+        compatible = "amlogic,meson-rng";
+        reg = <0x0 0xc8834000 0x0 0x4>;
+};
-- 
2.7.0
