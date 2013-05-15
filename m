From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 15 May 2013 10:58:47 -0400
Subject: [PATCHv2 2/3] arm: dts: add bandgap entry for OMAP443x devices
In-Reply-To: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1368629928-6723-3-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the bandgap entry for OMAP4430 devices.

Cc: "Beno?t Cousson" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index cccf39a..8d6c968 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -24,4 +24,8 @@
 			clock-latency = <300000>; /* From legacy driver */
 		};
 	};
+	bandgap {
+		reg = <0x4a002260 0x4 0x4a00232C 0x4>;
+		compatible = "ti,omap4430-bandgap";
+	};
 };
-- 
1.8.2.1.342.gfa7285d
