From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 24 Mar 2014 10:22:15 +0800
Subject: [PATCHv2 2/3] ARM: dts: vf610-twr: Add PWM0's pinctrl node
In-Reply-To: <1395627736-5338-1-git-send-email-Li.Xiubo@freescale.com>
References: <1395627736-5338-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1395627736-5338-3-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index f3af8ea..3fabdb5 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -213,6 +213,17 @@
 			>;
 		};
 
+		pinctrl_pwm0: pwm0grp {
+			fsl,pins = <
+				VF610_PAD_PTB0__FTM0_CH0		0x1582
+				VF610_PAD_PTB1__FTM0_CH1		0x1582
+				VF610_PAD_PTB2__FTM0_CH2		0x1582
+				VF610_PAD_PTB3__FTM0_CH3		0x1582
+				VF610_PAD_PTB6__FTM0_CH6		0x1582
+				VF610_PAD_PTB7__FTM0_CH7		0x1582
+			>;
+		};
+
 		pinctrl_sai2: sai2grp {
 			fsl,pins = <
 				VF610_PAD_PTA16__SAI2_TX_BCLK		0x02ed
-- 
1.8.4
