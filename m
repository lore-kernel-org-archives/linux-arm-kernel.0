From: sudeepkumar@cem-solutions.net (sudeep kumar)
Date: Fri, 24 Nov 2017 09:30:25 +0530
Subject: [PATCH 2/3] dt-bindings: arm: actions: Add Sparky
In-Reply-To: <20171114180114.26408-3-afaerber@suse.de>
References: <20171114180114.26408-1-afaerber@suse.de>
 <20171114180114.26408-3-afaerber@suse.de>
Message-ID: <00d701d364d8$c8a75780$59f60680$@cem-solutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by : sudeep <sudeepkumar@cem-solutions.net>

-----Original Message-----
From: Andreas F?rber [mailto:afaerber at suse.de] 
Sent: Tuesday, November 14, 2017 11:31 PM
To: linux-arm-kernel at lists.infradead.org
Cc: Thomas Liau <thomas.liau@actions-semi.com>; Jeff Chen <jeff.chen@actions-semi.com>; ??? <zhangdf@actions-semi.com>; ?? <liuwei@actions-semi.com>; ??? <tyzhang@actions-semi.com>; ?? <harrymei@actions-semi.com>; Ioan B <ioan@allo.com>; Sudeep Kumar <sudeepkumar@cem-solutions.net>; linux-kernel at vger.kernel.org; Andreas F?rber <afaerber@suse.de>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; devicetree at vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: actions: Add Sparky

Define a binding for Allo.com Sparky SBC.

Cc: Ioan B. <ioan@allo.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/actions.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
index 544a8855fad5..d54f33c4e0da 100644
--- a/Documentation/devicetree/bindings/arm/actions.txt
+++ b/Documentation/devicetree/bindings/arm/actions.txt
@@ -21,6 +21,7 @@ Boards:
 
 Root node property compatible must contain, depending on board:
 
+ - Allo.com Sparky: "allo,sparky"
  - Cubietech CubieBoard6: "cubietech,cubieboard6"
  - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
 
-- 
2.13.6
