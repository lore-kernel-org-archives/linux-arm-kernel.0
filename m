From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 19 Jan 2017 15:52:04 +0100
Subject: [PATCH v1 1/3] ARM: dts: tango4: Add alias for eth0
In-Reply-To: <bd989965-fa8a-a175-5e14-8467f01e6d5b@sigmadesigns.com>
References: <bd989965-fa8a-a175-5e14-8467f01e6d5b@sigmadesigns.com>
Message-ID: <6cabb1b4-2dd9-b64c-09d3-57b4d2fae0fc@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

http://elinux.org/Device_Tree_Usage#aliases_Node

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 arch/arm/boot/dts/tango4-vantage-1172.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tango4-vantage-1172.dts b/arch/arm/boot/dts/tango4-vantage-1172.dts
index 4cab64cb581e..e27b4a7801ab 100644
--- a/arch/arm/boot/dts/tango4-vantage-1172.dts
+++ b/arch/arm/boot/dts/tango4-vantage-1172.dts
@@ -8,6 +8,7 @@
 
 	aliases {
 		serial = &uart;
+		eth0 = &eth0;
 	};
 
 	memory at 80000000 {
-- 
2.10.0
