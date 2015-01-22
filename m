From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:07 +0100
Subject: [PATCH 01/13] ARM: dts: omap3-gta04: Fix backup-battery charging in
 devicetree file.
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-2-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Fix attribute names.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 655d6e9..fa39232 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -342,8 +342,8 @@
 };
 
 &charger {
-	bb_uvolt = <3200000>;
-	bb_uamp = <150>;
+	ti,bb-uvolt = <3200000>;
+	ti,bb-uamp = <150>;
 };
 
 /* spare */
-- 
1.9.1
