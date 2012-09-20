From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:12:19 +0200
Subject: [PATCH 01/32] ARM: ux500: Rename db8500.dtsi to dbx5x0.dtsi to
 encompass the u9500, u8540 and u9540
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348143170-2130-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/{db8500.dtsi => dbx5x0.dtsi} |    0
 arch/arm/boot/dts/snowball.dts                 |    2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/boot/dts/{db8500.dtsi => dbx5x0.dtsi} (100%)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
similarity index 100%
rename from arch/arm/boot/dts/db8500.dtsi
rename to arch/arm/boot/dts/dbx5x0.dtsi
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 7e334d4..df6fc57 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-/include/ "db8500.dtsi"
+/include/ "dbx5x0.dtsi"
 
 / {
 	model = "Calao Systems Snowball platform with device tree";
-- 
1.7.9.5
