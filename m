From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:09 +0100
Subject: [PATCH 03/13] ARM: dts: omap3-gta04: Enable mcbps2 necessary for audio
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-4-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

mcbsp2 is used in gta04 soundcard config and by default
is disabled so enable it for gta04.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index c78380e..7272591 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -449,3 +449,7 @@
 		};
 	};
 };
+
+&mcbsp2 {
+	status = "okay";
+};
-- 
1.9.1
