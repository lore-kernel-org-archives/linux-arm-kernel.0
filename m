From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 25 Jul 2014 12:40:03 -0600
Subject: [PATCH 2/2] ARM: tegra: apalis t30: fix device tree compatible node
In-Reply-To: <1406313603-11893-1-git-send-email-swarren@wwwdotorg.org>
References: <1406313603-11893-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1406313603-11893-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel@ziswiler.com>

Working on sound support I noticed the Apalis T30 Evaluation board
device tree missing the more generic Apalis T30 compatible string.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 992143372af0..45d40f024585 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -5,7 +5,7 @@
 
 / {
 	model = "Toradex Apalis T30 on Apalis Evaluation Board";
-	compatible = "toradex,apalis_t30-eval", "nvidia,tegra30";
+	compatible = "toradex,apalis_t30-eval", "toradex,apalis_t30", "nvidia,tegra30";
 
 	aliases {
 		rtc0 = "/i2c at 7000c000/rtc at 68";
-- 
1.9.1
