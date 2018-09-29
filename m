From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 29 Sep 2018 13:02:44 +0530
Subject: [PATCH] MAINTAINERS: Update clock binding entry for Actions Semi Owl
 SoCs
Message-ID: <20180929073244.7091-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit d0e45d686a3e ("dt-bindings: clock: Add S700 support for Actions
Semi Soc's")'

renamed the clock binding for Actions Semi Owl SoCs from
actions,s900-cmu.txt to actions,owl-cmu.txt inorder to accommodate all
members of Owl family SoCs. Hence, update the relevant entry in
MAINTAINERS file.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fff353db7536..e9d6ce3243ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1191,7 +1191,7 @@ F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
-F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
+F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
-- 
2.17.1
