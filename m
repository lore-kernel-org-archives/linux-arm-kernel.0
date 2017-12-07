From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:04 +0100
Subject: [PATCH 01/54] arm64: dts: renesas: salvator: set driver type for eMMC
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <d3decc2c34c8e69828918e69a63b35e927af709c.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

These boards are known to have eMMC issues with the default driver type.
Specify a working one.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index a298df74ca6c..24a32c63ce7c 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -596,6 +596,7 @@
 	bus-width = <8>;
 	mmc-hs200-1_8v;
 	non-removable;
+	fixed-emmc-driver-type = <1>;
 	status = "okay";
 };
 
-- 
2.11.0
