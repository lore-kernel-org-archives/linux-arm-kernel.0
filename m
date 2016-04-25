From: alexandre.torgue@gmail.com (Alexandre TORGUE)
Date: Mon, 25 Apr 2016 13:54:02 +0200
Subject: [PATCH v6 6/6] ARM: dts: stm32f429: Update Ethernet node on Eval board
In-Reply-To: <1461585242-32401-1-git-send-email-alexandre.torgue@gmail.com>
References: <1461585242-32401-1-git-send-email-alexandre.torgue@gmail.com>
Message-ID: <1461585242-32401-7-git-send-email-alexandre.torgue@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update new pinctrl phandle name and use new node name.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@gmail.com>

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 6bfc595..9a72445 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -94,9 +94,9 @@
 	clock-frequency = <25000000>;
 };
 
-&ethernet0 {
+&mac {
 	status = "okay";
-	pinctrl-0	= <&ethernet0_mii>;
+	pinctrl-0	= <&ethernet_mii>;
 	pinctrl-names	= "default";
 	phy-mode	= "mii-id";
 	mdio0 {
-- 
1.9.1
