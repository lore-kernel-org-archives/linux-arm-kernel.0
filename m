From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 14 Sep 2016 14:27:41 +0100
Subject: [PATCH 03/19] MAINTAINERS: Remove phy-miphy365x.c entry from STi arch
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1473859677-9231-4-git-send-email-peter.griffin@linaro.org>
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
index db814a8..12c271c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1754,7 +1754,6 @@ F:	drivers/media/rc/st_rc.c
 F:	drivers/media/platform/sti/c8sectpfe/
 F:	drivers/mmc/host/sdhci-st.c
 F:	drivers/phy/phy-miphy28lp.c
-F:	drivers/phy/phy-miphy365x.c
 F:	drivers/phy/phy-stih407-usb.c
 F:	drivers/phy/phy-stih41x-usb.c
 F:	drivers/pinctrl/pinctrl-st.c
-- 
1.9.1
