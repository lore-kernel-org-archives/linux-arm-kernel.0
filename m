From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Dec 2013 15:12:55 +0100
Subject: [PATCH RFCv1 5/6] ARM: mvebu: update Armada 370/XP DT to use new
 coherency compatible string
In-Reply-To: <1388067176-18177-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388067176-18177-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1388067176-18177-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the common Armada 370 and Armada XP Device Tree files to use
the new compatible string for the coherency fabric.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 7f10f62..c32f522 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -117,7 +117,7 @@
 			};
 
 			coherency-fabric at 20200 {
-				compatible = "marvell,coherency-fabric";
+				compatible = "marvell,armada-370-coherency-fabric";
 				reg = <0x20200 0xb0>, <0x21010 0x1c>;
 			};
 
-- 
1.8.3.2
