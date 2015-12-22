From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 22 Dec 2015 17:33:53 +0800
Subject: [PATCH 5/5] ARM: dts: enable the uart0 for bluetooth module
In-Reply-To: <1450776833-27639-1-git-send-email-wxt@rock-chips.com>
References: <1450776833-27639-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1450776833-27639-6-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3036-kylin.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index ed0466f..700f79a 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -338,6 +338,10 @@
 	pinctrl-0 = <&sdio_clk &sdio_cmd &sdio_bus4 &bt_wake_h>;
 };
 
+&uart0 {
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
1.9.1
