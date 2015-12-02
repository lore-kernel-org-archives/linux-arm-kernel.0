From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Wed,  2 Dec 2015 13:16:14 -0500
Subject: [PATCH v4 1/7] of: Add vendor prefix for Advantech Corporation
In-Reply-To: <1449080180-31945-1-git-send-email-akshay.bhat@timesys.com>
References: <1449080180-31945-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1449080180-31945-2-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds vendor prefix for Advantech Corporation.

Website: http://www.advantech.com/
Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 62ff22f..c51bf7c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -10,6 +10,7 @@ ad	Avionic Design GmbH
 adapteva	Adapteva, Inc.
 adh	AD Holdings Plc.
 adi	Analog Devices, Inc.
+advantech	Advantech Corporation
 aeroflexgaisler	Aeroflex Gaisler AB
 al	Annapurna Labs
 allwinner	Allwinner Technology Co., Ltd.
-- 
2.6.3
