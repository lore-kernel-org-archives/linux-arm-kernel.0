From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Apr 2011 03:01:46 -0700
Subject: genirq: Implement a generic interrupt chip
In-Reply-To: <20110419075729.GC477@atomide.com>
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.117340150@linutronix.de>
	<20110419075729.GC477@atomide.com>
Message-ID: <20110419100146.GE477@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110419 00:55]:
> * Thomas Gleixner <tglx@linutronix.de> [110416 14:20]:
> > --- linux-2.6.orig/include/linux/irq.h
> > +++ linux-2.6/include/linux/irq.h
> ...
> 
> > +/**
> > + * struct irq_chip_regs - register offsets for struct irq_gci
> > + * @enable:	Enable register offset to reg_base
> > + * @disable:	Disable register offset to reg_base
> > + * @mask:	Mask register offset to reg_base
> > + * @ack:	Ack register offset to reg_base
> > + * @ack:	Secondary Ack register offset to reg_base
> 
> Two @ack lines here?

Other than that seems to work for omap2 & 3. Posted a patch
for you too.

Tested-by: Tony Lindgren <tony@atomide.com>
