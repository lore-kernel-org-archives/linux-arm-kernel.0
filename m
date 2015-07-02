From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 17:06:29 +0300
Subject: [PATCH v2 14/20] ARM: DTS: am335x-evmsk: Fix mcasp1 node's indentation
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1435845995-19085-15-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The section had two tabs instead of one.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 156d05efcb70..2f62d915b438 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -661,19 +661,19 @@
 };
 
 &mcasp1 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&mcasp1_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp1_pins>;
 
-		status = "okay";
+	status = "okay";
 
-		op-mode = <0>;          /* MCASP_IIS_MODE */
-		tdm-slots = <2>;
-		/* 4 serializers */
-		serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
-			0 0 1 2
-		>;
-		tx-num-evt = <32>;
-		rx-num-evt = <32>;
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	/* 4 serializers */
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+		0 0 1 2
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
 };
 
 &tscadc {
-- 
2.4.5
