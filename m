From: kever.yang@rock-chips.com (Kever Yang)
Date: Fri,  8 Aug 2014 11:55:59 +0800
Subject: [PATCH v5 4/4] ARM: dts: Enable USB host1(dwc) on rk3288-evb
In-Reply-To: <1407470159-14722-1-git-send-email-kever.yang@rock-chips.com>
References: <1407470159-14722-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1407470159-14722-5-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB host1 port is the host A port nearby the otg port.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

---

Changes in v5:
- don't enable otg port for evb

Changes in v4: None
Changes in v3:
- Rebase

Changes in v2:
- evb patch added in version 2

 arch/arm/boot/dts/rk3288-evb.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 4f57209..4b62df6 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -94,3 +94,7 @@
 &usb_host0_ehci {
 	status = "okay";
 };
+
+&usb_host1 {
+	status = "okay";
+};
-- 
1.9.1
