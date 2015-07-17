From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 17 Jul 2015 11:32:44 +0200 (CEST)
Subject: [PATCH V4 1/1] irqchip: imx-gpcv2: IMX GPCv2 drivers for wakeup
 source and suspend
In-Reply-To: <alpine.DEB.2.11.1507171119250.18576@nanos>
References: <1436371523-18083-1-git-send-email-shenwei.wang@freescale.com>
 <BL2PR03MB370D2B063B9102C323A042283990@BL2PR03MB370.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1507171119250.18576@nanos>
Message-ID: <alpine.DEB.2.11.1507171130590.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jul 2015, Thomas Gleixner wrote:

> On Thu, 16 Jul 2015, Shenwei Wang wrote:
> 
> > Kindly PING.
> 
> If you folks would kindly CC the proper mailing list for irq chip
> patches, then they would end up in the proper mail folder and not in
> my random crap mbox.

And before you resend, please do what I asked you before:

This wants to be split in separate patches:
     - suspend code
     - irqchip code

Your V4 is still a combo patch:

>  arch/arm/mach-imx/Kconfig        |   1 +
>  arch/arm/mach-imx/Makefile       |   2 +
>  arch/arm/mach-imx/pm-imx7.c      | 735 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/suspend-imx7.S | 494 ++++++++++++++++++++++++++
>  drivers/irqchip/Kconfig          |   7 +
>  drivers/irqchip/Makefile         |   1 +
>  drivers/irqchip/irq-imx-gpcv2.c  | 311 +++++++++++++++++
>  include/soc/imx/gpcv2.h          | 137 ++++++++

Thanks,

	tglx
