From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 01 Jun 2016 11:54:01 +0200
Subject: [PATCH v7 6/6] extcon: max8997: Fix inconsistent indenting
In-Reply-To: <1464774841-1439-1-git-send-email-k.kozlowski@samsung.com>
References: <1464774841-1439-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1464774841-1439-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix smatch warning:
	max8997_muic_probe() warn: inconsistent indenting

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-max8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 0afa3e8b5dc3..cf8de5be2405 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -737,7 +737,7 @@ static int max8997_muic_probe(struct platform_device *pdev)
 	}
 
 	/* Set initial path for UART */
-	 max8997_muic_set_path(info, info->path_uart, true);
+	max8997_muic_set_path(info, info->path_uart, true);
 
 	/* Set ADC debounce time */
 	max8997_muic_set_debounce_time(info, ADC_DEBOUNCE_TIME_25MS);
-- 
1.9.1
