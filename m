From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 23 Jun 2018 00:06:30 +0800
Subject: [PATCH 1/2] arm64: allwinner: a64: change TERES-I DLDO3's name to
 start with "vdd"
Message-ID: <20180622160631.8578-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originally the name of the DLDO3 regulator on TERES-I is "eDP12", which
is not consistent with other regulator names.

Change it to "vdd-edp", in order to make it more consistent.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index d9baab3dc96b..02fecc42440c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -210,7 +210,7 @@
 &reg_dldo3 {
 	regulator-min-microvolt = <1200000>;
 	regulator-max-microvolt = <1200000>;
-	regulator-name = "eDP12";
+	regulator-name = "vdd-edp";
 };
 
 &reg_dldo4 {
-- 
2.17.1
