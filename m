From: romain.perier@gmail.com (Romain Perier)
Date: Tue, 20 Jan 2015 07:09:38 +0000
Subject: [PATCH v2 2/4] ARM: dts: Add regulator voltage settings for vcc_phy
 in rk3288-evb.dtsi
In-Reply-To: <1421737780-1533-1-git-send-email-romain.perier@gmail.com>
References: <1421737780-1533-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1421737780-1533-3-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 489643c..1c08eb0 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -98,6 +98,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&eth_phy_pwr>;
 		regulator-name = "vcc_phy";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 		regulator-boot-on;
 	};
-- 
1.9.1
