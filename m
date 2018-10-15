From: hannah@marvell.com (hannah at marvell.com)
Date: Mon, 15 Oct 2018 15:00:45 +0300
Subject: [PATCH 3/4] dt-bindings: iommu/arm,
 smmu: add compatible string for Marvell
In-Reply-To: <1539604846-21151-1-git-send-email-hannah@marvell.com>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
Message-ID: <1539604846-21151-4-git-send-email-hannah@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanna Hawa <hannah@marvell.com>

Add specific compatible string for Marvell usage due errata of
accessing 64bit registers of ARM SMMU, in AP806.

AP806 SOC use the generic ARM-MMU500, and there's no specific
implementation of Marvell, this compatible is used for errata only.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 8a6ffce..92d7263 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -16,6 +16,7 @@ conditions.
                         "arm,mmu-400"
                         "arm,mmu-401"
                         "arm,mmu-500"
+                        "marvell,mmu-500"
                         "cavium,smmu-v2"
 
                   depending on the particular implementation and/or the
-- 
1.9.1
