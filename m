From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 13 Dec 2017 02:20:47 -0500
Subject: [PATCH V8 1/7] Documentation: DT: qcom_hidma: Bump HW revision for
 the bugfixed HW
In-Reply-To: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
References: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1513149653-19451-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new version of the HIDMA IP has been released with bug fixes. Bumping the
hardware version to differentiate from others.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
index 55492c2..5d93d6d 100644
--- a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
@@ -47,8 +47,8 @@ When the OS is not in control of the management interface (i.e. it's a guest),
 the channel nodes appear on their own, not under a management node.
 
 Required properties:
-- compatible: must contain "qcom,hidma-1.0" for initial HW or "qcom,hidma-1.1"
-for MSI capable HW.
+- compatible: must contain "qcom,hidma-1.0" for initial HW or
+  "qcom,hidma-1.1"/"qcom,hidma-1.2" for MSI capable HW.
 - reg: Addresses for the transfer and event channel
 - interrupts: Should contain the event interrupt
 - desc-count: Number of asynchronous requests this channel can handle
-- 
1.9.1
