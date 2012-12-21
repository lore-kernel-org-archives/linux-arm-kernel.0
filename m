From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Dec 2012 15:49:14 +0100
Subject: [PATCH v2 15/20] arm: kirkwood: topkick: the Topkick platform uses a
 88F6282 SoC
In-Reply-To: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1356101359-6054-16-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Topkick board uses a 88F6282 SoC, so the Device Tree Source
describing the Topkick should inherit from kirkwood-6282.dtsi, which
allows to take advantage of pin muxing capabilities.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Changes since v1:
 * This patch is new in v2
---
 arch/arm/boot/dts/kirkwood-topkick.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index c0de5a7..8f4a5b8 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "kirkwood.dtsi"
+/include/ "kirkwood-6282.dtsi"
 
 / {
 	model = "Univeral Scientific Industrial Co. Topkick-1281P2";
-- 
1.7.9.5
