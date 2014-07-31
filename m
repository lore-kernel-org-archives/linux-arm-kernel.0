From: kever.yang@gmail.com (Kever Yang)
Date: Wed, 30 Jul 2014 21:29:59 -0700
Subject: [PATCH v2 4/4] ARM: dts: Enable USB otg and host1(dwc) on rk3288-evb
In-Reply-To: <1406780999-17798-1-git-send-email-kever.yang@rock-chips.com>
References: <1406780999-17798-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1406780999-17798-5-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB otg port is the usb3.0 b-port on the board.
USB host1 port is the host A port nearby the otg port.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2:
- evb patch added in version 2

 arch/arm/boot/dts/rk3288-evb.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index da665f6..aa60a3d 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -83,5 +83,11 @@
 		uart4: serial at ff1c0000 {
 			status = "okay";
 		};*/
+		&usb_otg {
+			status = "okay";
+		}
+		&usb_host1 {
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5
