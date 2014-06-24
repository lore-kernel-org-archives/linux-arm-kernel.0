From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Jun 2014 14:49:15 +0100
Subject: [PATCHv3 3/4] arm64: Update the Image header
In-Reply-To: <1403283810.17030.68.camel@smoke>
References: <1403174963-10730-1-git-send-email-mark.rutland@arm.com>
 <1403174963-10730-4-git-send-email-mark.rutland@arm.com>
 <1403283810.17030.68.camel@smoke>
Message-ID: <20140624134915.GK5856@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 06:03:30PM +0100, Geoff Levand wrote:
> Hi Mark,
> 
> On Thu, 2014-06-19 at 11:49 +0100, Mark Rutland wrote: 
> > diff --git a/arch/arm64/include/asm/image.h b/arch/arm64/include/asm/image.h
> > new file mode 100644
> > index 0000000..8fae075
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/image.h
> > @@ -0,0 +1,62 @@
> > +/*
> > + * Linker script macros to generate Image header fields.
> 
> ...
> 
> > + */
> > +#ifndef __ASM_IMAGE_H
> > +#define __ASM_IMAGE_H
> > +
> > +#ifndef LINKER_SCRIPT
> > +#error This file should only be included in vmlinux.lds.S
> > +#endif
> 
> Since this is just used by the linker script, shouldn't it go in
> arch/arm64/kernel/image.h?

Sure, that makes sense. I'll post a (hopefully final) v4 shortly.

Thanks,
Mark.
