From: zhouqiao@marvell.com (Qiao Zhou)
Date: Wed, 4 Jul 2012 08:47:54 -0700
Subject: [PATCH 1/4] mfd: support 88pm80x in 80x driver
In-Reply-To: <20120704153307.GE4111@opensource.wolfsonmicro.com>
References: <1341392115-9425-1-git-send-email-zhouqiao@marvell.com>
 <201207041137.49020.arnd@arndb.de>
 <B2A7C617B3AB7F44B7B44C7D374B431E13A09E8DEE@sc-vexch3.marvell.com>
 <201207041527.13954.arnd@arndb.de>
 <20120704153307.GE4111@opensource.wolfsonmicro.com>
Message-ID: <B2A7C617B3AB7F44B7B44C7D374B431E13A09E8DF1@sc-vexch3.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, Jul 04, 2012 at 03:27:13PM +0000, Arnd Bergmann wrote:
> > On Wednesday 04 July 2012, Qiao Zhou wrote:
>>
> > > >On the other hand, I think it probably makes sense to drop the 
> > > >irq_base member in this struct and rely on irq domains to allocate 
> > > >them dynamically as mentioned before.
>
> > > Do you mean that both regmap_add_irq_chip and mfd_add_devices api 
> > > pass -1 as the irq_base, so that system can dynamically allocate the irq_base for it?
>
> > regmap_add_irq_chip should pass -1, mfd_add_devices should pass 0.
> > Mark can probably correct me if that's wrong.
>
> That's right.
>
Mark, thanks for the confirmation.

Best Regards
Qiao
