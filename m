From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Sep 2015 00:05:21 +0800
Subject: [PATCH v4 5/5] ARM: dts: sun8i: sinlinx-sina33: Enable Reduced Serial
 Bus controller
In-Reply-To: <1443024323-9115-1-git-send-email-wens@csie.org>
References: <1443024323-9115-1-git-send-email-wens@csie.org>
Message-ID: <1443024323-9115-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Reduced Serial Bus controller is used to talk to the onboard PMIC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v3:

None

---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 1d5390d4e03a..13ce68f06dd6 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -130,6 +130,10 @@
 	};
 };
 
+&r_rsb {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_b>;
-- 
2.5.3
