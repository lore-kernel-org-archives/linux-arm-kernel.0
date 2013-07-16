From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 16 Jul 2013 14:40:30 -0300
Subject: [PATCH 2/2] ARM: dts: imx6q-wandboard: Add sata support
In-Reply-To: <1373996430-19854-1-git-send-email-fabio.estevam@freescale.com>
References: <1373996430-19854-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1373996430-19854-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-wandboard.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-wandboard.dts b/arch/arm/boot/dts/imx6q-wandboard.dts
index dde9b5d..78e1273 100644
--- a/arch/arm/boot/dts/imx6q-wandboard.dts
+++ b/arch/arm/boot/dts/imx6q-wandboard.dts
@@ -20,3 +20,7 @@
 		reg = <0x10000000 0x80000000>;
 	};
 };
+
+&sata {
+	status = "okay";
+};
-- 
1.8.1.2
