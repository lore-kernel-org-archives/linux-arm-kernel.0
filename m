From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 12 Apr 2016 16:16:42 +0100
Subject: [PATCH 3/5] MAINTAINERS: Add st-flashss driver to STi section.
In-Reply-To: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
References: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1460474204-5351-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the st-flashss regulator driver to the STi
section of the maintainers file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61a323a..93ef247 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1647,6 +1647,7 @@ F:	drivers/phy/phy-miphy365x.c
 F:	drivers/phy/phy-stih407-usb.c
 F:	drivers/phy/phy-stih41x-usb.c
 F:	drivers/pinctrl/pinctrl-st.c
+F:	drivers/regulator/st-flashss.c
 F:	drivers/reset/sti/
 F:	drivers/rtc/rtc-st-lpc.c
 F:	drivers/tty/serial/st-asc.c
-- 
1.9.1
