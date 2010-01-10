From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 10 Jan 2010 18:04:06 +0100
Subject: [PATCH 1/7] [ARM] sa1100: remove unreferenced IRQ definitions
In-Reply-To: <4B3CA5EC.30102@gmx.de>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
	<1261977488-18271-2-git-send-email-eric.y.miao@gmail.com>
	<4B3CA5EC.30102@gmx.de>
Message-ID: <201001101804.06642.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 31. prosince 2009 14:23:56 Thomas Kunze napsal(a):
> Eric Miao wrote:
> > These IRQ definitions related to LOCOMO are never referenced anywhere,
> > thus could be safely removed.
> >
> > Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> > ---
> >  arch/arm/mach-sa1100/include/mach/collie.h |    7 -------
> >  1 files changed, 0 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/mach-sa1100/include/mach/collie.h
> > b/arch/arm/mach-sa1100/include/mach/collie.h index 71a0b3f..52acda7
> > 100644
> > --- a/arch/arm/mach-sa1100/include/mach/collie.h
> > +++ b/arch/arm/mach-sa1100/include/mach/collie.h
> > @@ -72,13 +72,6 @@
> >  #define COLLIE_IRQ_GPIO_GA_INT		IRQ_GPIO25
> >  #define COLLIE_IRQ_GPIO_MAIN_BAT_LOW	IRQ_GPIO26
> >
> > -#define COLLIE_LCM_IRQ_GPIO_RTS		IRQ_LOCOMO_GPIO0
> > -#define COLLIE_LCM_IRQ_GPIO_CTS		IRQ_LOCOMO_GPIO1
> > -#define COLLIE_LCM_IRQ_GPIO_DSR		IRQ_LOCOMO_GPIO2
> > -#define COLLIE_LCM_IRQ_GPIO_DTR		IRQ_LOCOMO_GPIO3
> > -#define COLLIE_LCM_IRQ_GPIO_nSD_DETECT	IRQ_LOCOMO_GPIO13
> > -#define COLLIE_LCM_IRQ_GPIO_nSD_WP	IRQ_LOCOMO_GPIO14
> > -
> >  /* GPIO's on the TC35143AF (Toshiba Analog Frontend) */
> >  #define COLLIE_TC35143_GPIO_BASE	(GPIO_MAX + 13)
> >  #define COLLIE_TC35143_GPIO_VERSION0    UCB_IO_0
> 
> Those definitions are used in out-of-tree drivers. So please don't
> remove them.

Why aren't those in-the-tree already?
> 
> Regards,
> Thomas
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
