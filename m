From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu,  5 Nov 2015 13:13:35 -0500
Subject: [PATCH v2 01/10] of: Add vendor prefix for Advantech Corporation
In-Reply-To: <1446747224-32514-1-git-send-email-akshay.bhat@timesys.com>
References: <1446747224-32514-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1446747224-32514-2-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds vendor prefix for Advantech Corporation.

Website: http://www.advantech.com/
Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d4..2b3c5ac 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -10,6 +10,7 @@ ad	Avionic Design GmbH
 adapteva	Adapteva, Inc.
 adh	AD Holdings Plc.
 adi	Analog Devices, Inc.
+adv	Advantech Corporation
 aeroflexgaisler	Aeroflex Gaisler AB
 al	Annapurna Labs
 allwinner	Allwinner Technology Co., Ltd.
-- 
2.6.2
