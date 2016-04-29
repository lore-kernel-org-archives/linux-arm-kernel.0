From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 29 Apr 2016 10:32:19 -0700
Subject: [PATCH v2 4/4] ARM: dts: rockchip: Add mmc aliases for rk3288 platform
In-Reply-To: <1461951139-6109-1-git-send-email-dianders@chromium.org>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
Message-ID: <1461951139-6109-5-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that mmc aliases are officially in bindings, add them to rk3288.
This could be done to lots of platforms, but this is the one I tested
with.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- rk3288 patch new for v2

 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 31f7e20ef418..4cb15dcd1c1e 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -60,6 +60,10 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		mmc0 = &emmc;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio0;
+		mmc3 = &sdio1;
 		mshc0 = &emmc;
 		mshc1 = &sdmmc;
 		mshc2 = &sdio0;
-- 
2.8.0.rc3.226.g39d4020
