From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 16 Mar 2016 09:02:01 +0900
Subject: [PATCH] MAINTAINERS: pinctrl: samsung: Add two new maintainers
Message-ID: <1458086521-11220-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the list of maintainers for Samsung pinctrl driver with Sylwester
and Krzysztof.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Tomasz Figa still has the time for this driver (and, as the most recent
author, he really knows what is inside!) but sometimes a faster
response could be reached from Samsung folks.
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a16644726c08..8bc232400640 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8684,6 +8684,8 @@ F:	drivers/pinctrl/sh-pfc/
 
 PIN CONTROLLER - SAMSUNG
 M:	Tomasz Figa <tomasz.figa@gmail.com>
+M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.5.0
