From: zyw@rock-chips.com (Chris Zhong)
Date: Tue, 25 Nov 2014 17:37:32 +0800
Subject: [PATCH 1/2] ARM: dts: rockchip: change the max voltage of cpu to 1.4v
In-Reply-To: <1416908253-31721-1-git-send-email-zyw@rock-chips.com>
References: <1416908253-31721-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1416908253-31721-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the cpu frequencies up to 1.8Ghz, we need set the vdd_cpu to 1.4v.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 arch/arm/boot/dts/rk3288-evb-rk808.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
index d8c775e6..d4f74dd 100644
--- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -48,7 +48,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <1350000>;
+				regulator-max-microvolt = <1400000>;
 				regulator-name = "vdd_arm";
 			};
 
-- 
1.9.1
