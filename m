From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 29 Mar 2016 17:22:24 +0800
Subject: [PATCH resend v2 1/9] MAINTAINERS: Add entry for X-Powers AXP family
 PMIC drivers
In-Reply-To: <1459243352-23344-1-git-send-email-wens@csie.org>
References: <1459243352-23344-1-git-send-email-wens@csie.org>
Message-ID: <1459243352-23344-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry for X-Powers AXP family PMIC drivers and list myself
as maintainer.

Cc: Carlo Caione <carlo@caione.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03e00c7c88eb..53f2bdfa20c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12147,6 +12147,12 @@ F:	include/linux/workqueue.h
 F:	kernel/workqueue.c
 F:	Documentation/workqueue.txt
 
+X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS
+M:	Chen-Yu Tsai <wens@csie.org>
+L:	linux-kernel at vger.kernel.org
+S:	Maintained
+N:	axp[128]
+
 X.25 NETWORK LAYER
 M:	Andrew Hendry <andrew.hendry@gmail.com>
 L:	linux-x25 at vger.kernel.org
-- 
2.7.0
