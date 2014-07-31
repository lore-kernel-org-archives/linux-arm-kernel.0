From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu, 31 Jul 2014 14:26:25 -0700
Subject: [REPOST PATCH v3 5/5] ARM: dts: Enable USB otg and host1(dwc) on
 rk3288-evb
In-Reply-To: <1406841985-15790-1-git-send-email-kever.yang@rock-chips.com>
References: <1406841985-15790-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1406841985-15790-6-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB otg port is the usb3.0 b-port on the board.
USB host1 port is the host A port nearby the otg port.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

---

Changes in v3:
- Rebase

Changes in v2:
- evb patch added in version 2

 arch/arm/boot/dts/rk3288-evb.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 66f76a6..35a0837 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -127,3 +127,9 @@
 &usb_host0_ehci {
 	status = "okay";
 };
+&usb_host1 {
+	status = "okay";
+};
+&usb_otg {
+	status = "okay";
+};
-- 
1.7.9.5
