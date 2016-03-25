From: eric@anholt.net (Eric Anholt)
Date: Thu, 24 Mar 2016 17:23:47 -0700
Subject: [PATCH 1/5] of: Add vendor prefix for On Tat Industrial Company.
In-Reply-To: <1458865431-30048-1-git-send-email-eric@anholt.net>
References: <1458865431-30048-1-git-send-email-eric@anholt.net>
Message-ID: <1458865431-30048-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the vendor for a 7" DPI panel sold by Adafruit which I'd like
to describe in DT.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 72e2c5a..b35b5f8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -166,6 +166,7 @@ nxp	NXP Semiconductors
 okaya	Okaya Electric America, Inc.
 olimex	OLIMEX Ltd.
 onnn	ON Semiconductor Corp.
+ontat	On Tat Industrial Company
 opencores	OpenCores.org
 option	Option NV
 ortustech	Ortus Technology Co., Ltd.
-- 
2.7.0
