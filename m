From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 15 Jun 2017 11:04:15 +0800
Subject: [PATCH v4 18/20] dt-bindings: mmc: dw_mmc-k3: add document of hi3660
 mmc
In-Reply-To: <20170615030417.14059-1-guodong.xu@linaro.org>
References: <20170615030417.14059-1-guodong.xu@linaro.org>
Message-ID: <20170615030417.14059-19-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings for hi3660 mmc support

Signed-off-by: Li Wei <liwei213@huawei.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
index df37058..8af1afc 100644
--- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
@@ -12,6 +12,7 @@ extensions to the Synopsys Designware Mobile Storage Host Controller.
 Required Properties:
 
 * compatible: should be one of the following.
+  - "hisilicon,hi3660-dw-mshc": for controllers with hi3660 specific extensions.
   - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extensions.
   - "hisilicon,hi6220-dw-mshc": for controllers with hi6220 specific extensions.
 
-- 
2.10.2
