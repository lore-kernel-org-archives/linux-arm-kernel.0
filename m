From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 14 Sep 2016 14:27:42 +0100
Subject: [PATCH 04/19] MAINTAINERS: Remove phy-stih41x-usb.c entry from STi
 arch
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1473859677-9231-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove this driver as the IP is only found on STiH415/6
silicon, and support for these SoC's is being removed
from the kernel.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <kishon@ti.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12c271c..6a278b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1755,7 +1755,6 @@ F:	drivers/media/platform/sti/c8sectpfe/
 F:	drivers/mmc/host/sdhci-st.c
 F:	drivers/phy/phy-miphy28lp.c
 F:	drivers/phy/phy-stih407-usb.c
-F:	drivers/phy/phy-stih41x-usb.c
 F:	drivers/pinctrl/pinctrl-st.c
 F:	drivers/remoteproc/st_remoteproc.c
 F:	drivers/reset/sti/
-- 
1.9.1
