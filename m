From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Sep 2015 00:05:20 +0800
Subject: [PATCH v4 4/5] ARM: dts: sun8i: ippo-q8h-v5: Enable Reduced Serial
 Bus controller
In-Reply-To: <1443024323-9115-1-git-send-email-wens@csie.org>
References: <1443024323-9115-1-git-send-email-wens@csie.org>
Message-ID: <1443024323-9115-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Reduced Serial Bus controller is used to talk to the onboard PMIC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v3:

None

---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index 4f47fd654eea..af87e4922e44 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -58,6 +58,10 @@
 	status = "failed";
 };
 
+&r_rsb {
+	status = "okay";
+};
+
 /*
  * FIXME for now we only support host mode and rely on u-boot to have
  * turned on Vbus which is controlled by the axp223 pmic on the board.
-- 
2.5.3
