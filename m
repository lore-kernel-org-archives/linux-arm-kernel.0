From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 26 Dec 2013 15:49:00 +0530
Subject: [PATCH RESEND 3/4] mfd: sec-core: Add cells for S5M8767-clocks
In-Reply-To: <1388053141-30085-1-git-send-email-tushar.behera@linaro.org>
References: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
 <1388053141-30085-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1388053141-30085-4-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5M8767 chip has 3 crystal oscillators running at 32KHz. These are
supported by s2mps11-clk driver.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
CC: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/sec-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 66936b8..a139798 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -56,7 +56,9 @@ static const struct mfd_cell s5m8767_devs[] = {
 		.name = "s5m8767-pmic",
 	}, {
 		.name = "s5m-rtc",
-	},
+	}, {
+		.name = "s5m8767-clk",
+	}
 };
 
 static const struct mfd_cell s2mps11_devs[] = {
-- 
1.7.9.5
