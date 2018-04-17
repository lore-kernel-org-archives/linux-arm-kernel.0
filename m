From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Tue, 17 Apr 2018 13:48:00 +0100
Subject: [PATCH v2 1/3] dt-bindings: cpu: Add Renesas RZ/N1D SMP enable method.
In-Reply-To: <1523969291-41756-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523969291-41756-1-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <1523969291-41756-2-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a special enable method for second CA8 of the Renesas RZ/N1D
(R9A06G032).

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 29e1dc5..b395d107 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -219,6 +219,7 @@ described below.
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
 			    "renesas,apmu"
+			    "renesas,r9a06g032-smp"
 			    "rockchip,rk3036-smp"
 			    "rockchip,rk3066-smp"
 			    "ste,dbx500-smp"
-- 
2.7.4
