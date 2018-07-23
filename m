From: manu@freebsd.org (Emmanuel Vadot)
Date: Mon, 23 Jul 2018 12:42:54 +0200
Subject: [PATCH 3/4] ARM: dts: sun8i: h3: Add SID compatible string
In-Reply-To: <20180723104255.94244-1-manu@freebsd.org>
References: <20180723104255.94244-1-manu@freebsd.org>
Message-ID: <20180723104255.94244-3-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SID controller on H3 is one of it's kind (at least from what we
know).
Add a compatible string for it in the SoC dtsi.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 41d57c76f290..f543aa1dc829 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -185,3 +185,7 @@
 &pio {
 	compatible = "allwinner,sun8i-h3-pinctrl";
 };
+
+&sid {
+	compatible = "allwinner,sun8i-h3-sid";
+};
-- 
2.17.0
