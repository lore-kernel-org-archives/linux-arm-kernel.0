From: sudeepkumar@cem-solutions.net (sudeep kumar)
Date: Fri, 24 Nov 2017 09:31:58 +0530
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for Allo.com
In-Reply-To: <20171114180114.26408-2-afaerber@suse.de>
References: <20171114180114.26408-1-afaerber@suse.de>
 <20171114180114.26408-2-afaerber@suse.de>
Message-ID: <00d801d364d8$fcd8da60$f68a8f20$@cem-solutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by : sudeep <sudeepkumar@cem-solutions.net>

-----Original Message-----
From: Andreas F?rber [mailto:afaerber at suse.de] 
Sent: Tuesday, November 14, 2017 11:31 PM
To: linux-arm-kernel at lists.infradead.org
Cc: Thomas Liau <thomas.liau@actions-semi.com>; Jeff Chen <jeff.chen@actions-semi.com>; ??? <zhangdf@actions-semi.com>; ?? <liuwei@actions-semi.com>; ??? <tyzhang@actions-semi.com>; ?? <harrymei@actions-semi.com>; Ioan B <ioan@allo.com>; Sudeep Kumar <sudeepkumar@cem-solutions.net>; linux-kernel at vger.kernel.org; Andreas F?rber <afaerber@suse.de>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; devicetree at vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for Allo.com

ALLO is a Canadian-Indian manufacturer of telecommunications hardware.

Cc: Ioan B. <ioan@allo.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0994bdd82cd3..9bce76f3118d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -15,6 +15,7 @@ adi	Analog Devices, Inc.
 advantech	Advantech Corporation
 aeroflexgaisler	Aeroflex Gaisler AB
 al	Annapurna Labs
+allo	Allo.com
 allwinner	Allwinner Technology Co., Ltd.
 alphascale	AlphaScale Integrated Circuits Systems, Inc.
 altr	Altera Corp.
-- 
2.13.6
