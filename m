From: lyz@rock-chips.com (Yunzhi Li)
Date: Thu, 11 Dec 2014 18:11:34 +0800
Subject: [PATCH v6 5/5] ARM: dts: rockchip: Enable usb PHY on rk3288-evb board
In-Reply-To: <1418291722-25448-1-git-send-email-lyz@rock-chips.com>
References: <1418291722-25448-1-git-send-email-lyz@rock-chips.com>
Message-ID: <1418292694-25724-1-git-send-email-lyz@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable usb PHY for all usb ports on rk3288-evb.

Signed-off-by: Yunzhi Li <lyz@rock-chips.com>

---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None

 arch/arm/boot/dts/rk3288-evb.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index cb83cea..992f323 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -174,6 +174,10 @@
 	};
 };
 
+&usbphy {
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.0.0
