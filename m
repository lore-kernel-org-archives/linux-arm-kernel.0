From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 24 Jan 2015 18:26:21 +0100 (CET)
Subject: [PATCH v4 2/4] irqchip: mtk-sysirq: Get irq number from register
 resource size
In-Reply-To: <CABuKBeKJGx8mrjd+izR1zjxQNcWF+T2uUK=MbMbHYrXdRDTOyA@mail.gmail.com>
References: <1421054073-43468-1-git-send-email-eddie.huang@mediatek.com>
 <1421054073-43468-3-git-send-email-eddie.huang@mediatek.com>
 <CABuKBeKGbxR8YQcVPJyZDpnVsNUsTxQQhsisW_F2L13zfgeyjw@mail.gmail.com>
 <CABuKBeKJGx8mrjd+izR1zjxQNcWF+T2uUK=MbMbHYrXdRDTOyA@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1501241825410.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jan 2015, Matthias Brugger wrote:
> 2015-01-13 14:12 GMT+01:00 Matthias Brugger <matthias.bgg@gmail.com>:
> > 2015-01-12 10:14 GMT+01:00 Eddie Huang <eddie.huang@mediatek.com>:
> >> From: Yingjoe Chen <yingjoe.chen@mediatek.com>
> >>
> >> Originally mtk-sysirq hardcoded supported irq number to 224. This
> >> was fine since all SoCs before support the same number of irqs for
> >> intpol.
> >>
> >> However MT8173 intpol support 32 more irq pins, changes to get
> >> irq number from register resource size to suppor MT8173 properly.
> >>
> >> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> >> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> >> ---
> >>  drivers/irqchip/irq-mtk-sysirq.c | 18 +++++++++++-------
> >>  1 file changed, 11 insertions(+), 7 deletions(-)
> >>
> >
> > Jason, Thomas, will you take this patch through your branch?
> > I will take the rest of the series.
> >
> > Best regards,
> > Matthias
> >
> > --
> > motzblog.wordpress.com
> 
> Hi Thomas, hi Jason,
> 
> do you have any comments on this patch?

Jason is swamped. I'm currently collecting stuff.

Thanks,

	tglx
