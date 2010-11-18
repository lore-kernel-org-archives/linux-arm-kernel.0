From: inki.dae@samsung.com (Inki Dae)
Date: Thu, 18 Nov 2010 17:49:38 +0900
Subject: [PATCH 1/3] S5PV210: added MIPI-DSI driver.
Message-ID: <00b301cb86fd$8a461e10$9ed25a30$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Inki Dae <inki.dae@samsung.com>

---

 include/linux/fb.h |   12 ++++++++++++

 1 files changed, 12 insertions(+), 0 deletions(-)

 

diff --git a/include/linux/fb.h b/include/linux/fb.h

index 7fca3dc..9b9842c 100644

--- a/include/linux/fb.h

+++ b/include/linux/fb.h

@@ -1147,6 +1147,18 @@ struct fb_videomode {

          u32 flag;

 };

 

+struct fb_cpumode {

+         const char *name;          /* optional */

+         u32 refresh;                 /* optional */

+         u32 xres;

+         u32 yres;

+         u32 pixclock;

+         u32 cs_setup;

+         u32 wr_setup;

+         u32 wr_act;

+         u32 wr_hold;

+};

+

 extern const char *fb_mode_option;

 extern const struct fb_videomode vesa_modes[];

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101118/77182267/attachment-0001.html>
