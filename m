From: daeinki@gmail.com (InKi Dae)
Date: Tue, 23 Nov 2010 16:13:02 +0900
Subject: [PATCH 0/4] S5PC110: MIPI-DSI support.
Message-ID: <AANLkTi=_BAN2HewcDP+rKFY6fK4APLp_wFBDt1wXh9B9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

This patch is a MIPI-DSI driver for S5PC110.

PATCH 1/4 : add a structure for CPU interface to linux/fb.h
- RGB or CPU interface could be used as display mode but framebuffer
framework doesn?t consider CPU interface so I added this structure
because fb_cpumode structure could be used commonly.

PATCH 2/4 : add parameters for CPU interface to plat-samsung/fb.h
. MIPI-DSI driver would use s3c-fb driver so I added some parameters
because MIPI-DSI driver supports CPU interface also.

PATCH 3/4 : add MIPI-DSI support for platform and machine.

PATCH 4/4: add MIPI-DSI driver.

Thank you.
