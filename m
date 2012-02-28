From: javier.martin@vista-silicon.com (Javier Martin)
Date: Tue, 28 Feb 2012 17:31:50 +0100
Subject: [PATCH v2 3/4] i.MX27: visstrim_m10: Add m41t00 RTC support.
In-Reply-To: <1330446711-6970-1-git-send-email-javier.martin@vista-silicon.com>
References: <1330446711-6970-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1330446711-6970-4-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 1c26c6d..479d9e8 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -216,6 +216,9 @@ static struct i2c_board_info visstrim_m10_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("tlv320aic32x4", 0x18),
 		.platform_data = &visstrim_m10_aic32x4_pdata,
+	},
+	{
+		 I2C_BOARD_INFO("m41t00", 0x68),
 	}
 };
 
-- 
1.7.0.4
