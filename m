From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:48:54 +0200
Subject: [PATCH 05/13] ARM: dts: armada-385-linksys: bm pools by label order
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-6-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Which pools we assing doesn't matter. Use the order which doesen't leave
a chance for questions for first time readers.

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/boot/dts/armada-385-linksys.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index b7f0a16..932fca4 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -180,8 +180,8 @@
 	status = "okay";
 	phy-mode = "rgmii-id";
 	buffer-manager = <&bm>;
-	bm,pool-long = <2>;
-	bm,pool-short = <3>;
+	bm,pool-long = <0>;
+	bm,pool-short = <1>;
 	fixed-link {
 		speed = <1000>;
 		full-duplex;
@@ -192,8 +192,8 @@
 	status = "okay";
 	phy-mode = "sgmii";
 	buffer-manager = <&bm>;
-	bm,pool-long = <0>;
-	bm,pool-short = <1>;
+	bm,pool-long = <2>;
+	bm,pool-short = <3>;
 	fixed-link {
 		speed = <1000>;
 		full-duplex;
-- 
2.10.2
