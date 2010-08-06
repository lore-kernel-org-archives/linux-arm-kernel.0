From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 6 Aug 2010 09:36:42 -0700
Subject: [PATCH] arm: scoop.c: remove C99 comments
Message-ID: <201008060936.42524.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Comments should be /* */ not //.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Jiri Kosina <trivial@kernel.org>

---

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index 9012004..c11af1e 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -44,12 +44,12 @@ void reset_scoop(struct device *dev)
 {
 	struct scoop_dev *sdev = dev_get_drvdata(dev);
 
-	iowrite16(0x0100, sdev->base + SCOOP_MCR);  // 00
-	iowrite16(0x0000, sdev->base + SCOOP_CDR);  // 04
-	iowrite16(0x0000, sdev->base + SCOOP_CCR);  // 10
-	iowrite16(0x0000, sdev->base + SCOOP_IMR);  // 18
-	iowrite16(0x00FF, sdev->base + SCOOP_IRM);  // 14
-	iowrite16(0x0000, sdev->base + SCOOP_ISR);  // 1C
+	iowrite16(0x0100, sdev->base + SCOOP_MCR);  /* 00 */
+	iowrite16(0x0000, sdev->base + SCOOP_CDR);  /* 04 */
+	iowrite16(0x0000, sdev->base + SCOOP_CCR);  /* 10 */
+	iowrite16(0x0000, sdev->base + SCOOP_IMR);  /* 18 */
+	iowrite16(0x00FF, sdev->base + SCOOP_IRM);  /* 14 */
+	iowrite16(0x0000, sdev->base + SCOOP_ISR);  /* 1C */
 	iowrite16(0x0000, sdev->base + SCOOP_IRM);
 }
 
