From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Thu, 18 Nov 2010 13:30:30 +0200
Subject: [PATCH 0/3] S5PV210: added MIPI-DSI Driver.
In-Reply-To: <4CE50338.8060000@samsung.com>
References: <4CE50338.8060000@samsung.com>
Message-ID: <1290079830.9872.1.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2010-11-18 at 19:43 +0900, ext daeinki wrote:
> Hello all,
> 
> This patch is a MIPI-DSI driver for S5PV210.
> 
> PATCH 1/3: add a structure for CPU interface to linux/fb.h
> - RGB or CPU interfaces could be used as display mode but framebuffer
> framework doesn't consider CPU interface so I added this structure
> because fb_cpumode structure could be used commonly.
> 
> PATCH 2/3: add parameters for CPU interface to plat-samsung/fb.h
> - MIPI-DSI driver would use s3c-fb driver so I added some parameters
> because MIPI-DSI driver supports CPU interface also.
> 
> PATCH 3/3: add MIPI-DSI driver for S5PV210.

You have three patches, all with the same subject, and no description.

Please check Documentation/SubmittingPatches.

 Tomi
