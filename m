From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Tue, 18 Sep 2012 23:52:11 +0530
Subject: [PATCH 3/3] ARM: EXYNOS: Add drm-device node to the dtsi file
In-Reply-To: <1347992531-27279-1-git-send-email-l.krishna@samsung.com>
References: <1347992531-27279-1-git-send-email-l.krishna@samsung.com>
Message-ID: <1347992531-27279-4-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds platform drm-device node to the dtsi file

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 6d27ca4..b1fa93e 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -495,4 +495,8 @@
 		reg = <0x14400000 0x40000>;
 		interrupts = <18 5>, <18 4>, <18 6>;
 	};
+
+	drm-device {
+		compatible = "samsung,exynos-drm-device";
+	};
 };
-- 
1.7.0.4
