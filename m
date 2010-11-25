From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 25 Nov 2010 09:31:50 +0900
Subject: [PATCH 0/4] S5PC110: MIPI-DSI support.
In-Reply-To: <AANLkTi=_BAN2HewcDP+rKFY6fK4APLp_wFBDt1wXh9B9@mail.gmail.com>
References: <AANLkTi=_BAN2HewcDP+rKFY6fK4APLp_wFBDt1wXh9B9@mail.gmail.com>
Message-ID: <006501cb8c38$28c61b00$7a525100$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

InKi Dae wrote:
> 
> Hello all,
> 
> This patch is a MIPI-DSI driver for S5PC110.
> 
> PATCH 1/4 : add a structure for CPU interface to linux/fb.h
> - RGB or CPU interface could be used as display mode but framebuffer
> framework doesn't consider CPU interface so I added this structure
> because fb_cpumode structure could be used commonly.
> 
> PATCH 2/4 : add parameters for CPU interface to plat-samsung/fb.h
> . MIPI-DSI driver would use s3c-fb driver so I added some parameters
> because MIPI-DSI driver supports CPU interface also.
> 
> PATCH 3/4 : add MIPI-DSI support for platform and machine.
> 
> PATCH 4/4: add MIPI-DSI driver.
> 
> Thank you.

Hi,

Please~~~ add patch version and changes.
Otherwise, have to read/check everything again :-(
I think it is always helpful to reviewer or maintainer.

Is it possible to add it at least changes from your previous?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
