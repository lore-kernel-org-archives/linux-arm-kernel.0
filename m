From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Wed, 16 Apr 2014 10:19:46 +0800
Subject: [RFC][PATCH 2/3] ARM: dts: vf610-twr: Enable Freescale FlexTimer
 Module timer.
In-Reply-To: <1397614787-8300-1-git-send-email-Li.Xiubo@freescale.com>
References: <1397614787-8300-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1397614787-8300-3-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Jingchang Lu <b35083@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index e3a3805..0638847 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -130,6 +130,10 @@
 	};
 };
 
+&ftm0 {
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
1.8.4
