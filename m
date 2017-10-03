From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 3 Oct 2017 22:16:45 +0200
Subject: [PATCH 4/4] ARM: OMAP: Fix typos in two comment lines in
 _omap_dm_timer_request()
In-Reply-To: <b196ffac-4bd1-4465-cee9-e46b7405633d@users.sourceforge.net>
References: <b196ffac-4bd1-4465-cee9-e46b7405633d@users.sourceforge.net>
Message-ID: <fba4ace8-a277-fb08-7a6b-89d518ada080@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Oct 2017 21:24:00 +0200

Adjust three words in this description.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/plat-omap/dmtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 14779d6f425d..d443e481c3e9 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -254,8 +254,8 @@ static struct omap_dm_timer *_omap_dm_timer_request(int req_type, void *data)
 			if (cap == (t->capability & cap)) {
 				/*
 				 * If timer is not NULL, we have already found
-				 * one timer but it was not an exact match
-				 * because it had more capabilites that what
+				 * one timer. But it was not an exact match
+				 * because it had more capabilities than what
 				 * was required. Therefore, unreserve the last
 				 * timer found and see if this one is a better
 				 * match.
-- 
2.14.2
