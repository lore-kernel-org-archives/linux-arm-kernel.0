From: jon.mason@broadcom.com (Jon Mason)
Date: Wed,  3 Aug 2016 14:38:56 -0400
Subject: [PATCH 01/11] ARM: dts: NSP: Enable SATA on bcm958625hr
In-Reply-To: <1470249546-12440-1-git-send-email-jon.mason@broadcom.com>
References: <1470249546-12440-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1470249546-12440-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SATA support to bcm958625hr DTS

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm958625hr.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 4239e58..78970b9 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -158,3 +158,15 @@
 		};
 	};
 };
+
+&sata_phy0 {
+	status = "okay";
+};
+
+&sata_phy1 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
-- 
2.7.4
