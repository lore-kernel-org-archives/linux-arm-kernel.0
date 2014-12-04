From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 4 Dec 2014 22:58:20 +0100 (CET)
Subject: [PATCH v3 09/13] irqchip: GICv3: ITS: MSI support
In-Reply-To: <CALRxmdAULDXqx5oNUGQx9y2oUegULKO7=gWQWMRkFOzFo9XS8A@mail.gmail.com>
References: <1416839720-18400-1-git-send-email-marc.zyngier@arm.com>
 <1416839720-18400-10-git-send-email-marc.zyngier@arm.com>
 <CALRxmdAULDXqx5oNUGQx9y2oUegULKO7=gWQWMRkFOzFo9XS8A@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1412042257000.16275@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Dec 2014, Stuart Yoder wrote:
> On Mon, Nov 24, 2014 at 8:35 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> > +/*
> > + * We need a value to serve as a irq-type for LPIs. Choose one that will
> > + * hopefully pique the interest of the reviewer.
> > + */
> > +#define GIC_IRQ_TYPE_LPI               0xa110c8ed
> 
> Ok, my interest is piqued.  Why this value?

Hint: 0x1337
