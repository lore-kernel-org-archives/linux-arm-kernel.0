From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 May 2014 15:19:06 -0400
Subject: [PATCH 5/7] irqchip: s3c24xx: fix function type for
 IRQCHIP_OF_DECLARE
In-Reply-To: <CAL_JsqJuYwkyy0UO75D1XmAKZa3ui3zYYBi55xFOWUFVgFw5=g@mail.gmail.com>
References: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
 <1399940993-1773-6-git-send-email-robherring2@gmail.com>
 <20140513152233.GB27822@titan.lakedaemon.net>
 <CAL_JsqJuYwkyy0UO75D1XmAKZa3ui3zYYBi55xFOWUFVgFw5=g@mail.gmail.com>
Message-ID: <20140513191906.GI27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 12:02:06PM -0500, Rob Herring wrote:
> On Tue, May 13, 2014 at 10:22 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > Rob,
> >
> > On Mon, May 12, 2014 at 07:29:51PM -0500, Rob Herring wrote:
> >> From: Rob Herring <robh@kernel.org>
> >>
> >> Adding function type checking to IRQCHIP_OF_DECLARE found a type mismatch
> >> with s3c2410_init_intc_of and s3c2416_init_intc_of. The function only takes
> >> the 1st 2 parameters.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> ---
> >>  drivers/irqchip/irq-s3c24xx.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > Thomas has asked me to give him a hand with the patches for
> > drivers/irqchip.  When you add these two to your tree, could you amend
> > the subject line to conform with the other patches in that directory?
> 
> Excellent! We've needed some help there for a long time. Is there a
> patch in flight to add this to MAINTAINERS.

See:

  https://lkml.kernel.org/r/1400006821-32145-1-git-send-email-jason at lakedaemon.net

and it's now in irq/urgent in the tip tree.

thx,

Jason.
