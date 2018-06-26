From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 26 Jun 2018 09:50:09 +0200
Subject: [PATCH 1/2] ARM: dts: ux500: Correct SCU unit address
In-Reply-To: <20180626075010.15611-1-geert+renesas@glider.be>
References: <20180626075010.15611-1-geert+renesas@glider.be>
Message-ID: <20180626075010.15611-2-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The unit address of the Cortex-A9 SCU device node contains one zero too
many.  Remove it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 2310a4e97768c222..3dc0028e108b3d49 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -197,7 +197,7 @@
 			      <0xa0410100 0x100>;
 		};
 
-		scu at a04100000 {
+		scu at a0410000 {
 			compatible = "arm,cortex-a9-scu";
 			reg = <0xa0410000 0x100>;
 		};
-- 
2.17.1
