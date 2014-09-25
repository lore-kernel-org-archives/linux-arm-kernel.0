From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 25 Sep 2014 18:28:39 +0200
Subject: [PATCH v3 12/13] ARM: shmobile: r8a7740 dtsi: Add preliminary PM
 domain latencies
In-Reply-To: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1411662520-22795-13-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now use 250 ?s, just like the legacy platform code does.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New, split off from "ARM: shmobile: r8a7740 dtsi: Add PM domain
    support".

 arch/arm/boot/dts/r8a7740.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 4fead480a405bebe..ed0adeb61a1ad8ec 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -563,16 +563,22 @@
 				pd_a4lc: a4lc at 1 {
 					reg = <1>;
 					#power-domain-cells = <0>;
+					power-on-latency = <250000>;
+					power-off-latency = <250000>;
 				};
 
 				pd_a4mp: a4mp at 2 {
 					reg = <2>;
 					#power-domain-cells = <0>;
+					power-on-latency = <250000>;
+					power-off-latency = <250000>;
 				};
 
 				pd_d4: d4 at 3 {
 					reg = <3>;
 					#power-domain-cells = <0>;
+					power-on-latency = <250000>;
+					power-off-latency = <250000>;
 				};
 
 				pd_a4r: a4r at 5 {
@@ -580,10 +586,14 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <0>;
+					power-on-latency = <250000>;
+					power-off-latency = <250000>;
 
 					pd_a3rv: a3rv at 6 {
 						reg = <6>;
 						#power-domain-cells = <0>;
+						power-on-latency = <250000>;
+						power-off-latency = <250000>;
 					};
 				};
 
@@ -592,26 +602,36 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <0>;
+					power-on-latency = <250000>;
+					power-off-latency = <250000>;
 
 					pd_a3sp: a3sp at 11 {
 						reg = <11>;
 						#power-domain-cells = <0>;
+						power-on-latency = <250000>;
+						power-off-latency = <250000>;
 					};
 
 					pd_a3sm: a3sm at 12 {
 						reg = <12>;
 						#power-domain-cells = <0>;
+						power-on-latency = <250000>;
+						power-off-latency = <250000>;
 					};
 
 					pd_a3sg: a3sg at 13 {
 						reg = <13>;
 						#power-domain-cells = <0>;
+						power-on-latency = <250000>;
+						power-off-latency = <250000>;
 					};
 				};
 
 				pd_a4su: a4su at 20 {
 					reg = <20>;
 					#power-domain-cells = <0>;
+					power-on-latency = <250000>;
+					power-off-latency = <250000>;
 				};
 			};
 		};
-- 
1.9.1
