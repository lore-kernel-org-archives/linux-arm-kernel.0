From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 May 2014 03:10:07 +0200
Subject: [PATCH v6 03/12] ARM: shmobile: r7s72100: genmai: populate nodes for
 external clocks
In-Reply-To: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
References: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1400029816-24028-4-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index e664611a47c8..941e72ce7c82 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -30,6 +30,14 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <13330000>;
+};
+
+&usb_x1_clk {
+	clock-frequency = <48000000>;
+};
+
 &i2c2 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
1.9.2
