From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 17:06:32 +0300
Subject: [PATCH v2 17/20] ARM: DTS: am335x-evm: Fix mcasp1 node's indentation
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1435845995-19085-18-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The section had two tabs instead of one.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 765be2766eb0..9cfb591a7f80 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -575,19 +575,19 @@
 #include "tps65910.dtsi"
 
 &mcasp1 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&am335x_evm_audio_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&am335x_evm_audio_pins>;
 
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
 
 &tps {
-- 
2.4.5
