From: shameerali.kolothum.thodi@huawei.com (shameer)
Date: Sat, 13 May 2017 10:47:27 +0100
Subject: [RFC v1 3/7] iommu/arm-smmu-v3: Replace the device tree binding for
 hisilicon broken prefetch cmd with erratum id
In-Reply-To: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
Message-ID: <20170513094731.3676-4-shameerali.kolothum.thodi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index be57550..bf48e92 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -46,7 +46,7 @@ the PCIe specification.
                         devicetree/bindings/interrupt-controller/msi.txt
                       for a description of the msi-parent property.
 
-- hisilicon,broken-prefetch-cmd
+- hisilicon,erratum-161010701
                     : Avoid sending CMD_PREFETCH_* commands to the SMMU.
 
 ** Example
-- 
2.5.0
