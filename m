From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 20 May 2015 11:07:39 +0800
Subject: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <CABuKBeJcpufi-eEWmDRK6F2kgpz3DmCz8rp4hVPCJVgkmGr-KA@mail.gmail.com>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
 <20150518184300.GB28888@pengutronix.de>
 <CABuKBeJcpufi-eEWmDRK6F2kgpz3DmCz8rp4hVPCJVgkmGr-KA@mail.gmail.com>
Message-ID: <1432091259.20394.7.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-19 at 16:48 +0200, Matthias Brugger wrote:
> 2015-05-18 20:43 GMT+02:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
<...>
> >> --- /dev/null
> >> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> >> @@ -0,0 +1,675 @@
> >> +/*
> >> + * Copyright (c) 2014 MediaTek Inc.
> >> + * Author: Xudong.chen <xudong.chen@mediatek.com>
> > s/Xudong.chen/Xudong Chen/
> >
> >> +#define I2C_DRV_NAME         "mt-i2c"
> > i2c-mt65xx ?
> 
> As this works for all SoCs so far, I would propose: i2c-mtk

Hi,

I'm pretty sure this driver won't work for MTK TV socs(mt53xx) and BDP
mt8580, they are using different I2C IP. They are not working on
upstream now, but I think using i2c-mt65xx make more sense here.

Joe.C
