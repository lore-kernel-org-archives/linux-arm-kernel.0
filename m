From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 07 Jun 2012 12:09:56 +0100
Subject: [CFT 11/11] Add feature removal of old OMAP private DMA implementation
In-Reply-To: <20120607110610.GB15973@n2100.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Message-ID: <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 Documentation/feature-removal-schedule.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 56000b3..1f7ba35 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -612,3 +612,14 @@ When:	June 2013
 Why:	Unsupported/unmaintained/unused since 2.6
 
 ----------------------------
+
+What:	OMAP private DMA implementation
+When:	2013
+Why:	We have a DMA engine implementation; all users should be updated
+	to use this rather than persisting with the old APIs.  The old APIs
+	block merging the old DMA engine implementation into the DMA
+	engine driver.
+Who:	Russell King <linux@arm.linux.org.uk>,
+	Santosh Shilimkar <santosh.shilimkar@ti.com>
+
+----------------------------
-- 
1.7.4.4
