From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 24 Aug 2015 20:31:42 +0200 (CEST)
Subject: [PATCH v8 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <BY1PR0301MB0839B8F390ABA092FB80362083620@BY1PR0301MB0839.namprd03.prod.outlook.com>
References: <1438378439-11569-1-git-send-email-shenwei.wang@freescale.com>
 <1438378439-11569-2-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1508231251040.3873@nanos>
 <CY1PR0301MB084328829F8128A8FBFA6A9283620@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1508241933150.3873@nanos>
 <BY1PR0301MB0839B8F390ABA092FB80362083620@BY1PR0301MB0839.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.11.1508242031050.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Aug 2015, Shenwei Wang wrote:
> > That's what you want achieve. Still you save the full content of the registers and
> > restore the full content. That saves/restores the enabled and disabled interrupts.
> > So enabled_irqs is a misnomer as you save the full state.
> 
> How about change its name to "saved_irq_mask"?

Way better.
 
Thanks,
 
 	tglx
