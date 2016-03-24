From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 24 Mar 2016 13:25:20 +0900
Subject: [PATCH v5 11/21] MAINTAINERS: Add samsung bus frequency driver entry
In-Reply-To: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1458793530-31897-12-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the 'BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS' entry to review the
patches as maintainer. Patches will be picked up by DEVFREQ maintainer
on devfreq git repository.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32bafda47c2f..9040f6a89ffe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3539,6 +3539,15 @@ F:	drivers/devfreq/devfreq-event.c
 F:	include/linux/devfreq-event.h
 F:	Documentation/devicetree/bindings/devfreq/event/
 
+BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS
+M:	Chanwoo Choi <cw00.choi@samsung.com>
+L:	linux-pm at vger.kernel.org
+L:	linux-samsung-soc at vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Maintained
+F:	drivers/devfreq/exynos-bus.c
+F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+
 DEVICE NUMBER REGISTRY
 M:	Torben Mathiasen <device@lanana.org>
 W:	http://lanana.org/docs/device-list/index.html
-- 
1.9.1
