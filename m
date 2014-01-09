From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 9 Jan 2014 16:00:39 +0200
Subject: [PATCHv13 28/40] ARM: dts: AM35xx: use DT clock data
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Message-ID: <1389276051-1326-29-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM35xx now uses the clock data from device tree. Most of the data is
shared with OMAP3xxx, but as there is some delta, a new base .dtsi
file is also created for the SoC.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am3517.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 2fbe02f..788391f 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -61,3 +61,6 @@
 		};
 	};
 };
+
+/include/ "am35xx-clocks.dtsi"
+/include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
-- 
1.7.9.5
