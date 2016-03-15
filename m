From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 15 Mar 2016 11:58:40 +0900
Subject: [PATCH v2 1/5] dt-bindings: gk20a: Fix typo in compatible name
In-Reply-To: <1458010724-10945-1-git-send-email-acourbot@nvidia.com>
References: <1458010724-10945-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1458010724-10945-2-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct compatible name is "nvidia,gk20a".

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
index 23bfe8e1f7cc..914f0ff4020e 100644
--- a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
+++ b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
@@ -1,9 +1,9 @@
 NVIDIA GK20A Graphics Processing Unit
 
 Required properties:
-- compatible: "nvidia,<chip>-<gpu>"
+- compatible: "nvidia,<gpu>"
   Currently recognized values:
-  - nvidia,tegra124-gk20a
+  - nvidia,gk20a
 - reg: Physical base address and length of the controller's registers.
   Must contain two entries:
   - first entry for bar0
-- 
2.7.2
