From: javier.martin@vista-silicon.com (Javier Martin)
Date: Mon, 26 Mar 2012 13:20:04 +0200
Subject: [PATCH 3/3] i.MX27: visstrim_m10: Remove use of MX2_CAMERA_SWAP16.
In-Reply-To: <1332760804-22743-1-git-send-email-javier.martin@vista-silicon.com>
References: <1332760804-22743-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1332760804-22743-4-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 3128cfe..4db00c6 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -164,7 +164,7 @@ static struct platform_device visstrim_tvp5150 = {
 
 
 static struct mx2_camera_platform_data visstrim_camera = {
-	.flags = MX2_CAMERA_CCIR | MX2_CAMERA_CCIR_INTERLACE | MX2_CAMERA_SWAP16 | MX2_CAMERA_PCLK_SAMPLE_RISING,
+	.flags = MX2_CAMERA_CCIR | MX2_CAMERA_CCIR_INTERLACE | MX2_CAMERA_PCLK_SAMPLE_RISING,
 	.clk = 100000,
 };
 
-- 
1.7.0.4
