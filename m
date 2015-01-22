From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:10 +0100
Subject: [PATCH 04/13] ARM: dts: omap3-gta04: Enable twl audio vibra support
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-5-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 7272591..fd6ac80 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -205,6 +205,7 @@
 
 		twl_audio: audio {
 			compatible = "ti,twl4030-audio";
+			ti,enable-vibra = <1>;
 			codec {
 			};
 		};
-- 
1.9.1
