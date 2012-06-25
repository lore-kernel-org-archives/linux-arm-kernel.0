From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 25 Jun 2012 14:56:20 +0800
Subject: [PATCH v7 03/14] usb: chipidea: msm: add missing section annotation
In-Reply-To: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1340607391-16380-4-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

no functional changes, it will just free up some
code if we don't have hotplug.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/usb/chipidea/ci13xxx_msm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci13xxx_msm.c b/drivers/usb/chipidea/ci13xxx_msm.c
index 958069e..8d438b8 100644
--- a/drivers/usb/chipidea/ci13xxx_msm.c
+++ b/drivers/usb/chipidea/ci13xxx_msm.c
@@ -55,7 +55,7 @@ static struct ci13xxx_udc_driver ci13xxx_msm_udc_driver = {
 	.notify_event		= ci13xxx_msm_notify_event,
 };
 
-static int ci13xxx_msm_probe(struct platform_device *pdev)
+static int __devinit ci13xxx_msm_probe(struct platform_device *pdev)
 {
 	struct platform_device *plat_ci;
 	int ret;
-- 
1.7.9.5
