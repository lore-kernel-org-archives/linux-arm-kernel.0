From: eric@anholt.net (Eric Anholt)
Date: Wed,  7 Mar 2018 10:57:15 -0800
Subject: [PATCH v2 5/6] staging: vc04_services: Mark the "DT bindings" job
 done.
In-Reply-To: <20180307185716.17449-1-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net>
Message-ID: <20180307185716.17449-5-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we just need to get the other drivers merged and finish the style
cleanups/garbage collecting so we can get out of staging.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: no changes

 drivers/staging/vc04_services/interface/vchi/TODO | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/TODO b/drivers/staging/vc04_services/interface/vchi/TODO
index df93154b1aa6..46b20a1961a2 100644
--- a/drivers/staging/vc04_services/interface/vchi/TODO
+++ b/drivers/staging/vc04_services/interface/vchi/TODO
@@ -1,9 +1,4 @@
-1) Write a DT binding doc and get the corresponding DT node merged to
-   bcm2835.
-
-This will let the driver probe when enabled.
-
-2) Import drivers using VCHI.
+1) Import drivers using VCHI.
 
 VCHI is just a tool to let drivers talk to the firmware.  Here are
 some of the ones we want:
@@ -26,7 +21,7 @@ some of the ones we want:
   to manage these buffers as dmabufs so that we can zero-copy import
   camera images into vc4 for rendering/display.
 
-3) Garbage-collect unused code
+2) Garbage-collect unused code
 
 One of the reasons this driver wasn't upstreamed previously was that
 there's a lot code that got built that's probably unnecessary these
-- 
2.16.2
