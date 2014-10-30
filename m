From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 14:55:20 +0900
Subject: [PATCH/RFC] ARM: shmobile: lager: Add I2C2 clock frequency to device
 tree
Message-ID: <1414648520-30184-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
[simon: rebased]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

If this is useful I wonder if it is should be set in the lager board DTS
file instead of the r8a7790 SoC DTSI file.


 arch/arm/boot/dts/r8a7790-lager.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 830f2e8..32c7e48 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -426,6 +426,7 @@
 
 &iic2	{
 	status = "ok";
+	clock-frequency = <400000>;
 	pinctrl-0 = <&iic2_pins>;
 	pinctrl-names = "default";
 
-- 
2.1.1
