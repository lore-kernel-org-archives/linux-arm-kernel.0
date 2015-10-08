From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 08 Oct 2015 14:34:05 +0900
Subject: [PATCH 4/5] thermal: exynos: Remove unneeded semicolon
In-Reply-To: <1444282446-6419-1-git-send-email-k.kozlowski@samsung.com>
References: <1444282446-6419-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1444282446-6419-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove semicolons after switch statement.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index eac6aebf82f3..1af7ea8dda71 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -548,7 +548,7 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
 	default:
 		pdata->cal_type = TYPE_ONE_POINT_TRIMMING;
 		break;
-	};
+	}
 
 	dev_info(&pdev->dev, "Calibration type is %d-point calibration\n",
 			cal_type ?  2 : 1);
@@ -1356,7 +1356,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		break;
 	default:
 		break;
-	};
+	}
 
 	/*
 	 * data->tzd must be registered before calling exynos_tmu_initialize(),
-- 
1.9.1
