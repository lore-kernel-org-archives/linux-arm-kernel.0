From: jan.tuerk@emtrion.com (Jan Tuerk)
Date: Thu, 23 Nov 2017 13:55:53 +0100
Subject: [PATCH 3/5] ARM: dts: imx: Add an cpu0 label for imx6dl devices.
In-Reply-To: <20171123125600.41562-1-jan.tuerk@emtrion.com>
References: <20171123125600.41562-1-jan.tuerk@emtrion.com>
Message-ID: <20171123125600.41562-4-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the label cpu0 allows the adjustment of cpu-parameters
by reference in overlaying dtsi files in the same way as it
is possible for imx6q devices.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 4d693a75ce98..623c12519b81 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -21,7 +21,7 @@
                #address-cells = <1>;
                #size-cells = <0>;

-               cpu at 0 {
+               cpu0: cpu at 0 {
                        compatible = "arm,cortex-a9";
                        device_type = "cpu";
                        reg = <0>;
--
2.11.0


emtrion GmbH
Kreativpark - Alter Schlachthof 45
76131 Karlsruhe
GERMANY
http://www.emtrion.de
_______________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_______________________________________
