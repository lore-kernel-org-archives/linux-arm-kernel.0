From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 20 Jul 2013 11:17:58 +0400
Subject: [PATCH 5/6] ARM: dts: i.MX27: Remove clock name from CPU node
In-Reply-To: <1374304679-27338-1-git-send-email-shc_work@mail.ru>
References: <1374304679-27338-1-git-send-email-shc_work@mail.ru>
Message-ID: <1374304679-27338-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock name is not needed for "cpufreq-cpu0".

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index c06df85..76cd89f 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -63,7 +63,6 @@
 			>;
 			clock-latency = <62500>;
 			clocks = <&clks 18>;
-			clock-names = "cpu";
 			voltage-tolerance = <5>;
 		};
 	};
-- 
1.8.1.5
