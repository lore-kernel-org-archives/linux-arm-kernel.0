From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:13 +0100
Subject: [PATCH 07/13] ARM: dts: omap3-gta04: Add ramp value for twl4030 audio
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-8-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index b56c85b..6f5fcbb 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -207,6 +207,7 @@
 			compatible = "ti,twl4030-audio";
 			ti,enable-vibra = <1>;
 			codec {
+				ti,ramp_delay_value = <3>;
 			};
 		};
 
-- 
1.9.1
