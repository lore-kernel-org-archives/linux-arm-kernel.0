From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:43 +0200
Subject: [PATCH 24/26] ARM: dts: r8a7792: fix misindented line
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <d6f5fe84b5f99ab3fad6911b825098ebdeb4a921.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Commit 2a0900655d5e (ARM: dts: r8a7792: add I2C support) had a wrongly
indented line at the end of the "aliases" subnode -- fix it.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index e1f85a9904d0..eaa0c48c6184 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -31,7 +31,7 @@
 		vin3 = &vin3;
 		vin4 = &vin4;
 		vin5 = &vin5;
-};
+	};
 
 	cpus {
 		#address-cells = <1>;
-- 
2.7.0.rc3.207.g0ac5344
