From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 29 Sep 2015 10:37:03 +0800
Subject: [PATCH v3 7/8] ARM: dts: enable smp for rk3036
In-Reply-To: <1443492833-15630-1-git-send-email-zhengxing@rock-chips.com>
References: <1443492833-15630-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1443494223-15952-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the rk3036's cpu1 and smp.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v3: None

 arch/arm/boot/dts/rk3036.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index fea51de..ecd053d 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -72,6 +72,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "rockchip,rk3036-smp";
 
 		cpu0: cpu at f00 {
 			device_type = "cpu";
-- 
1.7.9.5
