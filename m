From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:25 +0200
Subject: [PATCH 16/32] bcm2837-rpi-3-b.dts: move the emmc pin group
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-17-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index a523bd7..8579df3 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -34,8 +34,8 @@
 		     &pcm_gpio18
 		     &pwm0_gpio40
 		     &pwm1_gpio45
-		     &gpioout
-		     &alt3>;
+		     &emmc_gpio48
+		     &gpioout>;
 };
 
 &uart1 {
-- 
1.8.3.1
