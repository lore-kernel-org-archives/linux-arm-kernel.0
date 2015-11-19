From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 19 Nov 2015 12:31:02 +0530
Subject: [PATCH 2/2] arm: dts: am4372: add spi alias for qspi
In-Reply-To: <1447916462-1007-1-git-send-email-mugunthanvnm@ti.com>
References: <1447916462-1007-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <1447916462-1007-3-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the alias for qspi to spi0

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d83ff9c..bb03b80 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -30,6 +30,7 @@
 		serial5 = &uart5;
 		ethernet0 = &cpsw_emac0;
 		ethernet1 = &cpsw_emac1;
+		spi0 = &qspi;
 	};
 
 	cpus {
-- 
2.6.2.280.g74301d6
