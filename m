From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu,  7 Feb 2013 10:45:28 +0530
Subject: [PATCH 4/5] ARM: dts: exynos5250-arndale: Add MFC codec support
In-Reply-To: <1360214129-4096-1-git-send-email-tushar.behera@linaro.org>
References: <1360214129-4096-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1360214129-4096-4-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sachin Kamat <sachin.kamat@linaro.org>

Added MFC codec node to Arndale DT file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/boot/dts/exynos5250-arndale.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index d018fd2..6162a72 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -24,6 +24,11 @@
 		bootargs = "console=ttySAC2,115200";
 	};
 
+	codec at 11000000 {
+		samsung,mfc-r = <0x43000000 0x800000>;
+		samsung,mfc-l = <0x51000000 0x800000>;
+	};
+
 	i2c at 12C60000 {
 		status = "okay";
 		samsung,i2c-sda-delay = <100>;
-- 
1.7.4.1
