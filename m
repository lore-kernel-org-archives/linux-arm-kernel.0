From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon,  7 Apr 2014 16:29:26 +0200
Subject: [PATCH 3/4] ARM: dts: imx6: edmqmx6: USB H1 only supports host mode
In-Reply-To: <1396880967-16319-1-git-send-email-l.stach@pengutronix.de>
References: <1396880967-16319-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1396880967-16319-3-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index af32944cf9ae..e7762e456cbe 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -346,6 +346,7 @@
 &usbh1 {
 	vbus-supply = <&reg_usb_host1>;
 	disable-over-current;
+	dr_mode = "host";
 	status = "okay";
 };
 
-- 
1.9.1
