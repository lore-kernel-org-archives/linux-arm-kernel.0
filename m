From: niej0001@gmail.com (Jun Nie)
Date: Mon, 16 Nov 2009 17:34:39 +0800
Subject: [PATCH 4/8] pxa: delete redundant vsync/hsync revert flag
Message-ID: <7c34ac520911160134r736e78cfh1d968fcf1d70e123@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Nie <njun@marvell.com>
Date: Tue, 10 Nov 2009 15:11:36 +0800
Subject: [PATCH] pxa: delete redundant vsync/hsync revert flag
var.sync can cover its function

Signed-off-by: Jun Nie <njun@marvell.com>
---
 include/video/pxa168fb.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index 01c18bc..53919fe 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -143,8 +143,6 @@ struct pxa168fb_mach_info {
 	unsigned	invert_composite_blank:1;
 	unsigned	invert_pix_val_ena:1;
 	unsigned	invert_pixclock:1;
-	unsigned	invert_vsync:1;
-	unsigned	invert_hsync:1;
 	unsigned	panel_rbswap:1;
 	unsigned	active:1;
 	unsigned	enable_lcd:1;
-- 
1.5.4.3
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-pxa-delete-redundant-vsync-hsync-revert-flag-var.sy.patch
Type: text/x-diff
Size: 815 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091116/411d5f4f/attachment.bin>
