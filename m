From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 24 Jun 2015 16:11:10 +0100
Subject: [PATCH 12/12] MAINTAINERS: Add c8sectpfe driver directory to STi
 section
In-Reply-To: <1435158670-7195-1-git-send-email-peter.griffin@linaro.org>
References: <1435158670-7195-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1435158670-7195-13-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new c8sectpfe demux driver to the STi section of the
MAINTAINERS file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8afd29..49c8963 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1481,6 +1481,7 @@ F:	arch/arm/boot/dts/sti*
 F:	drivers/clocksource/arm_global_timer.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
+F:	drivers/media/tsin/c8sectpfe/
 F:	drivers/mmc/host/sdhci-st.c
 F:	drivers/phy/phy-miphy28lp.c
 F:	drivers/phy/phy-miphy365x.c
-- 
1.9.1
