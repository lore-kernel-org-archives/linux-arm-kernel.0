From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu,  7 Aug 2014 17:34:55 +0800
Subject: [PATCH v4 4/4] ARM: dts: Enable USB otg and host1(dwc) on rk3288-evb
In-Reply-To: <1407404095-3265-1-git-send-email-kever.yang@rock-chips.com>
References: <1407404095-3265-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1407404095-3265-5-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB otg port is the usb3.0 b-port on the board.
USB host1 port is the host A port nearby the otg port.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

---

Changes in v4: None
Changes in v3:
- Rebase

Changes in v2:
- evb patch added in version 2

 arch/arm/boot/dts/rk3288-evb.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 4f57209..a322100 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -94,3 +94,9 @@
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
1.9.1
