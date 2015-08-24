From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Mon, 24 Aug 2015 19:32:53 +0000
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <alpine.DEB.2.11.1508242127230.15006@nanos>
References: <1440443055-7291-1-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1508242112450.15006@nanos>
 <BY1PR0301MB0839B96E88B2CCFF8A9D794783620@BY1PR0301MB0839.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1508242127230.15006@nanos>
Message-ID: <BY1PR0301MB083938F8FF90B12466F9F64883620@BY1PR0301MB0839.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you, Thomas!

Shenwei

> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: 2015?8?24? 14:30
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; jason at lakedaemon.net;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Huang
> Yongcai-B20788
> Subject: RE: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> 
> On Mon, 24 Aug 2015, Shenwei Wang wrote:
> > > Ok, last question. How is Anson related to this? He did not convey
> > > your patch and in the first posted versions his SOB was never there.
> >
> > This patch was based on his internal version of GPCv2 driver. I reused
> > some of his implementation and ported it to latest linux kernel.
> > Adding his name here to give the credits to him.
> 
> So the proper way to express this is:
> 
> Based-on-a-patch-by: Anson
> Signed-off-by: You
> 
> The way you did it suggests that you wrote it and Anson conveyed it, which is not
> the case.
> 
> I'll change it that way then.
> 
> Thanks,
> 
> 	tglx
