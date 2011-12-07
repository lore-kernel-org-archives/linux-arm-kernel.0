From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  7 Dec 2011 23:16:24 +0100
Subject: [PATCH] pinctrl: remove two unused global variables
Message-ID: <1323296184-30227-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/pinmux.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index a5467f8..f2c84a9 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -32,10 +32,6 @@
 static DEFINE_MUTEX(pinmux_list_mutex);
 static LIST_HEAD(pinmux_list);
 
-/* List of pinmux hogs */
-static DEFINE_MUTEX(pinmux_hoglist_mutex);
-static LIST_HEAD(pinmux_hoglist);
-
 /* Global pinmux maps, we allow one set only */
 static struct pinmux_map const *pinmux_maps;
 static unsigned pinmux_maps_num;
-- 
1.7.7.3
