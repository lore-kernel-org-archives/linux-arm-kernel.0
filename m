From: t.remmet@phytec.de (Teresa Remmet)
Date: Thu, 5 Jan 2017 15:50:49 +0100
Subject: [PATCH 4/6] ARM: dts: am335x-wega: Set USB0 mode to otg
In-Reply-To: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
Message-ID: <1483627851-17996-5-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set USB0 to otg mode (default) and not fix to peripheral.
As it can be used in host mode also.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-wega.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 02c6736..e97fd6d 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -206,7 +206,6 @@
 };
 
 &usb0 {
-	dr_mode = "peripheral";
 	status = "okay";
 };
 
-- 
1.9.1
