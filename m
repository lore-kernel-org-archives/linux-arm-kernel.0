From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Sep 2012 10:48:55 +0100
Subject: [RFC 2/3] ARM: move udc_pxa2xx.h to linux/platform_data
In-Reply-To: <CAMPhdO_xqpqUUbSvi1zC4eT6vr0xFO-70+ieknjMWk9h0iWfHg@mail.gmail.com>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
 <E1TEzet-00077v-VD@rmk-PC.arm.linux.org.uk>
 <CAMPhdO_xqpqUUbSvi1zC4eT6vr0xFO-70+ieknjMWk9h0iWfHg@mail.gmail.com>
Message-ID: <20120921094855.GC15609@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 05:40:07PM +0800, Eric Miao wrote:
> On Fri, Sep 21, 2012 at 5:36 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > diff --git a/arch/arm/mach-ixp4xx/include/mach/udc.h b/arch/arm/mach-ixp4xx/include/mach/udc.h
> > index 80d6da2..b47cc0d 100644
> > --- a/arch/arm/mach-ixp4xx/include/mach/udc.h
> > +++ b/arch/arm/mach-ixp4xx/include/mach/udc.h
> > @@ -2,7 +2,7 @@
> >   * arch/arm/mach-ixp4xx/include/mach/udc.h
> >   *
> >   */
> > -#include <asm/mach/udc_pxa2xx.h>
> > +#include <linux/platform_data_pxa2xx_udc.h>
> 
> Guess a typo here, "/" instead of "_"? Otherwise looks good to me

Yea, fixed.
