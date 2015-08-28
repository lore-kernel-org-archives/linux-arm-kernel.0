From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 17:59:43 +0200
Subject: [PATCH 08/11] arm: tegra: colibri_t30: replace emmc label by comment
In-Reply-To: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440777586-19545-9-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than a bogus label just add a comment identifying the SDHCI
instance connected to the on-module eMMC.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 5f8ec5c..67ba943 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -396,7 +396,8 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
-	emmc: sdhci at 78000600 {
+	/* eMMC */
+	sdhci at 78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
-- 
2.4.3
