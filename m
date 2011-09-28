From: richard.zhu@linaro.org (Richard Zhu)
Date: Wed, 28 Sep 2011 15:41:55 +0800
Subject: [PATCH V9 3/5] MX53 Enable the AHCI SATA on MX53 ARD board
In-Reply-To: <1317195717-21174-1-git-send-email-richard.zhu@linaro.org>
References: <1317195717-21174-1-git-send-email-richard.zhu@linaro.org>
Message-ID: <1317195717-21174-4-git-send-email-richard.zhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 arch/arm/mach-mx5/board-mx53_ard.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 76a67c4..ef2039e 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -234,6 +234,7 @@ static void __init mx53_ard_board_init(void)
 	imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
 	imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
 	imx_add_gpio_keys(&ard_button_data);
+	imx53_add_ahci_imx();
 }
 
 static void __init mx53_ard_timer_init(void)
-- 
1.7.1
