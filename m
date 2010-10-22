From: joe@perches.com (Joe Perches)
Date: Thu, 21 Oct 2010 22:17:15 -0700
Subject: [PATCH 4/9] drivers/rtc: typo fix of faild to failed
In-Reply-To: <cover.1287724261.git.joe@perches.com>
References: <cover.1287724261.git.joe@perches.com>
Message-ID: <4279ee540bfed9c40ba26698bfe7abddb8921ee4.1287724261.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/rtc/rtc-nuc900.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-nuc900.c b/drivers/rtc/rtc-nuc900.c
index 62de66a..ddb0857 100644
--- a/drivers/rtc/rtc-nuc900.c
+++ b/drivers/rtc/rtc-nuc900.c
@@ -274,7 +274,7 @@ static int __devinit nuc900_rtc_probe(struct platform_device *pdev)
 	nuc900_rtc->rtcdev = rtc_device_register(pdev->name, &pdev->dev,
 						&nuc900_rtc_ops, THIS_MODULE);
 	if (IS_ERR(nuc900_rtc->rtcdev)) {
-		dev_err(&pdev->dev, "rtc device register faild\n");
+		dev_err(&pdev->dev, "rtc device register failed\n");
 		err = PTR_ERR(nuc900_rtc->rtcdev);
 		goto fail3;
 	}
-- 
1.7.3.1.g432b3.dirty
