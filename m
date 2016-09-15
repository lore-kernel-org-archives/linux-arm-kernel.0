From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 15 Sep 2016 13:22:38 -0400
Subject: [PATCH V3 02/10] Documentation: DT: qcom_hidma: correct spelling
 mistakes
In-Reply-To: <1473960166-30155-1-git-send-email-okaya@codeaurora.org>
References: <1473960166-30155-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1473960166-30155-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the spelling mistakes and extra and statements in the sentences.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
index 47bfb5a..f99f642 100644
--- a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
@@ -5,13 +5,13 @@ memcpy and memset capabilities. It has been designed for virtualized
 environments.
 
 Each HIDMA HW instance consists of multiple DMA channels. These channels
-share the same bandwidth. The bandwidth utilization can be parititioned
+share the same bandwidth. The bandwidth utilization can be partitioned
 among channels based on the priority and weight assignments.
 
 There are only two priority levels and 15 weigh assignments possible.
 
 Other parameters here determine how much of the system bus this HIDMA
-instance can use like maximum read/write request and and number of bytes to
+instance can use like maximum read/write request and number of bytes to
 read/write in a single burst.
 
 Main node required properties:
-- 
1.9.1
