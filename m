From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Feb 2018 16:41:16 -0600
Subject: [PATCH 2/2] arm64: dts: replace 'linux,
 stdout-path' with 'stdout-path'
In-Reply-To: <20180228224116.2596-1-robh@kernel.org>
References: <20180228224116.2596-1-robh@kernel.org>
Message-ID: <20180228224116.2596-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'linux,stdout-path' has been deprecated for some time in favor of
'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
Search and replace the one occurrence with 'stdout-path'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 22723527e626..00dd89b92b42 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -23,7 +23,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = &serial_2;
+		stdout-path = &serial_2;
 	};
 
 	memory at 40000000 {
-- 
2.14.1
