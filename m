From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 26 Jul 2010 08:40:35 +0300
Subject: [PATCH RFC] h1940: use gpiolib for latch access
In-Reply-To: <20100725223521.GA14747@n2100.arm.linux.org.uk>
References: <1280076072-1049-1-git-send-email-anarsoul@gmail.com>
	<20100725223521.GA14747@n2100.arm.linux.org.uk>
Message-ID: <201007260841.25560.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 26 ???? 2010 01:35:21 ????? Russell King - ARM Linux ???????:
> On Sun, Jul 25, 2010 at 07:41:12PM +0300, Vasily Khoruzhick wrote:
> > diff --git a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> > b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h index
> > d8a8327..4607d5c 100644
> > --- a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> > +++ b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> > @@ -14,51 +14,30 @@
> > 
> >  #ifndef __ASM_ARCH_H1940_LATCH_H
> >  #define __ASM_ARCH_H1940_LATCH_H
> > 
> > +#include <mach/gpio.h>
> 
> Would linux/gpio.h make more sense here?

Nope, mach/gpio.h is for S3C_GPIO_END

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100726/df34cbd1/attachment.sig>
