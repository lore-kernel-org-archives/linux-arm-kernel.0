From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 29 Aug 2012 16:31:01 +0300
Subject: [PATCH v2 2/8] ARM/dts: omap2420-h4: Include omap2420.dtsi file
 instead the common omap2
In-Reply-To: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1346247067-9632-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the board is based on OMAP2420 we should include the dedicated dtsi
file (which includes the common omap2 dtsi).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap2420-h4.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
index 25b50b7..77b84e1 100644
--- a/arch/arm/boot/dts/omap2420-h4.dts
+++ b/arch/arm/boot/dts/omap2420-h4.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap2.dtsi"
+/include/ "omap2420.dtsi"
 
 / {
 	model = "TI OMAP2420 H4 board";
-- 
1.7.8.6
