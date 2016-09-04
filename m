From: andy.yan@rock-chips.com (Andy Yan)
Date: Sun,  4 Sep 2016 16:33:10 +0800
Subject: [PATCH 1/4] ARM: dts: rockchip: enable usbotg for Popemtal-rk3288
 board
In-Reply-To: <1472977937-758-1-git-send-email-andy.yan@rock-chips.com>
References: <1472977937-758-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1472977990-813-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB OTG port on RK3288 Popmetal board, So we can run
some usb gadget functions like Android adb on this board.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

 arch/arm/boot/dts/rk3288-popmetal.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index bd35392..802216f 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -529,3 +529,7 @@
 &usbphy {
 	status = "okay";
 };
+
+&usb_otg {
+	status = "okay";
+};
-- 
2.7.4
