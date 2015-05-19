From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 May 2015 21:49:17 +0200
Subject: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <CABuKBeJcpufi-eEWmDRK6F2kgpz3DmCz8rp4hVPCJVgkmGr-KA@mail.gmail.com>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
 <20150518184300.GB28888@pengutronix.de>
 <CABuKBeJcpufi-eEWmDRK6F2kgpz3DmCz8rp4hVPCJVgkmGr-KA@mail.gmail.com>
Message-ID: <20150519194917.GI24769@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Matthias,

On Tue, May 19, 2015 at 04:48:23PM +0200, Matthias Brugger wrote:
> 2015-05-18 20:43 GMT+02:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> >> [...]
> >>  drivers/i2c/busses/i2c-mt65xx.c | 675 ++++++++++++++++++++++++++++++++++++++++
> >> [...]
> >> +#define I2C_DRV_NAME         "mt-i2c"
> > i2c-mt65xx ?
> 
> As this works for all SoCs so far, I would propose: i2c-mtk
Hmm, currently we have:

  - #define I2C_DRV_NAME mt-i2c
  - dt-compatibles: "mediatek,mt6577-i2c" + "mediatek,mt6589-i2c"
  - function prefix: mtk_i2c_
  - filename: i2c-mt65xx.c
  - Kconfig symbol: I2C_MT65XX

Getting some harmonization here would definitly be nice.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
