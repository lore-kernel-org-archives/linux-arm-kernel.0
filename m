From: briannorris@chromium.org (Brian Norris)
Date: Thu,  1 Dec 2016 18:27:27 -0800
Subject: [PATCH 3/9] arm64: dts: rockchip: add rk3399 eDP HPD pinctrl
In-Reply-To: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
Message-ID: <1480645653-36943-4-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We haven't enabled eDP support yet, but we might as well describe the
pin now.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 28772f6e77f0..4ca8f9a7601c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1435,6 +1435,13 @@
 			};
 		};
 
+		edp {
+			edp_hpd: edp-hpd {
+				rockchip,pins =
+					<4 23 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
 		gmac {
 			rgmii_pins: rgmii-pins {
 				rockchip,pins =
-- 
2.8.0.rc3.226.g39d4020
