From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 5 Dec 2011 10:53:17 +0100
Subject: [PATCH] pcmcia: pxa: replace IRQ_GPIO() with gpio_to_irq()
In-Reply-To: <CAMPhdO8F8QLjfeJReXSHgJNg+iaJ+CQ9i50ozsqAOiPWxhfwNA@mail.gmail.com>
References: <1323075548.20963.7.camel@phoenix>
 <CAMPhdO8F8QLjfeJReXSHgJNg+iaJ+CQ9i50ozsqAOiPWxhfwNA@mail.gmail.com>
Message-ID: <201112051053.17618.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Dec 5, 2011 at 4:59 PM, Axel Lin <axel.lin@gmail.com> wrote:
> > Since commit 6384fd "ARM: pxa: rename IRQ_GPIO to PXA_GPIO_TO_IRQ",
> > I got buid errors due to implicit declaration of function 'IRQ_GPIO'.
> > 
> > Use common gpio_to_irq() to replace machine dependant macro IRQ_GPIO().
> > 
> > Cc: Marek Vasut <marek.vasut@gmail.com>
> > Cc: Ian Molton <spyro@f2s.com>
> > Cc: Jonathan Cameron <jic23@cam.ac.uk>
> > Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> > Cc: Eric Miao <eric.y.miao@gmail.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Axel Lin <axel.lin@gmail.com>
> 
> Looks fine to me.
> 
> Acked-by: Eric Miao <eric.y.miao@gmail.com>

I did a quick skim over the patch:

Acked-by: Marek Vasut <marek.vasut@gmail.com>
