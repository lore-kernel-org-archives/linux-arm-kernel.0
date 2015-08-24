From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 24 Aug 2015 21:30:20 +0200 (CEST)
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <BY1PR0301MB0839B96E88B2CCFF8A9D794783620@BY1PR0301MB0839.namprd03.prod.outlook.com>
References: <1440443055-7291-1-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1508242112450.15006@nanos>
 <BY1PR0301MB0839B96E88B2CCFF8A9D794783620@BY1PR0301MB0839.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.11.1508242127230.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Aug 2015, Shenwei Wang wrote:
> > Ok, last question. How is Anson related to this? He did not convey your patch and
> > in the first posted versions his SOB was never there.
> 
> This patch was based on his internal version of GPCv2 driver. I reused some of his
> implementation and ported it to latest linux kernel. Adding his name here to give 
> the credits to him.

So the proper way to express this is:

Based-on-a-patch-by: Anson
Signed-off-by: You

The way you did it suggests that you wrote it and Anson conveyed it,
which is not the case.

I'll change it that way then.

Thanks,

	tglx
