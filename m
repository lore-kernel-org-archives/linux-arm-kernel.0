From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 19 Nov 2015 12:31:01 +0530
Subject: [PATCH 1/2] dts: dra7: add spi alias for qspi
In-Reply-To: <1447916462-1007-1-git-send-email-mugunthanvnm@ti.com>
References: <1447916462-1007-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <1447916462-1007-2-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the alias for qspi to spi0

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index bc672fb..b2badf9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -41,6 +41,7 @@
 		ethernet1 = &cpsw_emac1;
 		d_can0 = &dcan1;
 		d_can1 = &dcan2;
+		spi0 = &qspi;
 	};
 
 	timer {
-- 
2.6.2.280.g74301d6
