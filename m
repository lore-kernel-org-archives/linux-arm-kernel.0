From: joel@jms.id.au (Joel Stanley)
Date: Mon, 11 Dec 2017 15:37:04 +1030
Subject: [PATCH 20/20] ARM: dts: aspeed-plametto: Add flash layout
In-Reply-To: <20171211050704.20621-1-joel@jms.id.au>
References: <20171211050704.20621-1-joel@jms.id.au>
Message-ID: <20171211050704.20621-21-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OpenBMC flash layout is used by Palmetto systems.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index a8f0c046e83e..cc18137386f2 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -34,6 +34,7 @@
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
+#include "openbmc-flash-layout.dtsi"
 	};
 };
 
-- 
2.14.1
