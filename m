From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 31 Oct 2013 12:18:43 +0530
Subject: [PATCH 3/4] mfd: sec-core: Add cells for S5M8767-clocks
In-Reply-To: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
References: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1383202124-1775-4-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5M8767 chip has 3 crystal oscillators running at 32KHz. These are
supported by s2mps11-clk driver.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
CC: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/sec-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 34c18fb..020b86b 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -56,7 +56,9 @@ static struct mfd_cell s5m8767_devs[] = {
 		.name = "s5m8767-pmic",
 	}, {
 		.name = "s5m-rtc",
-	},
+	}, {
+		.name = "s5m8767-clk",
+	}
 };
 
 static struct mfd_cell s2mps11_devs[] = {
-- 
1.7.9.5
