From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 May 2014 16:09:32 -0500
Subject: [PATCH 06/10] dts: versatile: add pl180 compatible strings
In-Reply-To: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
Message-ID: <1400620176-7239-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

While not needed for probing, add the "arm,pl180" compatible string for
completeness.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/versatile-ab.dts | 2 +-
 arch/arm/boot/dts/versatile-pb.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 90a9f61..e4cba63 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -188,7 +188,7 @@
 				interrupts = <24>;
 			};
 			mmc at 5000 {
-				compatible = "arm,primecell";
+				compatible = "arm,pl180", "arm,primecell";
 				reg = < 0x5000 0x1000>;
 				interrupts-extended = <&vic 22 &sic 2>;
 			};
diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index 65f6577..a428541 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -39,7 +39,7 @@
 				interrupts = <5>;
 			};
 			mmc at b000 {
-				compatible = "arm,primecell";
+				compatible = "arm,pl180", "arm,primecell";
 				reg = <0xb000 0x1000>;
 				interrupts-extended = <&vic 23 &sic 2>;
 			};
-- 
1.9.1
