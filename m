From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Oct 2017 20:01:45 -0200
Subject: [PATCH] ARM: dts: imx6qp-wandboard-revd1: Add sata support
Message-ID: <1508191305-13747-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The imx6qp variant also has sata, so add support for it.

Reported-by: Lu?s Mendes <luis.p.mendes@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts b/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
index 7df5d96..f7badd8 100644
--- a/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
+++ b/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
@@ -20,3 +20,7 @@
 		reg = <0x10000000 0x80000000>;
 	};
 };
+
+&sata {
+	status = "okay";
+};
-- 
2.7.4
