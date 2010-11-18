From: inki.dae@samsung.com (Inki Dae)
Date: Thu, 18 Nov 2010 17:48:20 +0900
Subject: [PATCH 0/3] S5PV210: added MIPI-DSI driver.
Message-ID: <00ae01cb86fd$5a4b4000$0ee1c000$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

 

This patch is a MIPI-DSI driver for S5PV210.

 

PATCH 1/3 : add a structure for CPU interface to linux/fb.h

. RGB or CPU interface could be used as display mode but framebuffer
framework doesn't consider CPU interface

 So I added this structure because fb_cpumode structure could be used
commonly.

PATCH 2/3 : add parameters for CPU interface to plat-samsung/fb.h

. MIPI-DSI driver would use s3c-fb driver so I added some parameters because
MIPI-DSI driver supports CPU interface also.

PATCH 3/3 : add MIPI-DSI driver for S5PV210.

 

Thank you.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101118/baadb134/attachment-0001.html>
