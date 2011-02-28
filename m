From: John.Linn@xilinx.com (John Linn)
Date: Mon, 28 Feb 2011 07:22:52 -0700
Subject: [PATCH V4 3/4] ARM: Xilinx: base header files and assemblymacros
In-Reply-To: <20110228112055.GC29843@n2100.arm.linux.org.uk>
References: <1298052881-14591-1-git-send-email-john.linn@xilinx.com>
	<1298052881-14591-2-git-send-email-john.linn@xilinx.com>
	<1298052881-14591-3-git-send-email-john.linn@xilinx.com>
	<42efee69-aca1-446b-a997-f0063e113877@VA3EHSMHS009.ehs.local>
	<20110228112055.GC29843@n2100.arm.linux.org.uk>
Message-ID: <b5d1dbd3-91ed-4199-b416-c9cd923ad72b@VA3EHSMHS029.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, February 28, 2011 4:21 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org;
linux-kernel at vger.kernel.org; catalin.marinas at arm.com;
> glikely at secretlab.ca; jamie at jamieiles.com; arnd at arndb.de
> Subject: Re: [PATCH V4 3/4] ARM: Xilinx: base header files and
assemblymacros
> 
> On Fri, Feb 18, 2011 at 11:14:40AM -0700, John Linn wrote:
> > diff --git a/arch/arm/mach-xilinx/include/mach/uncompress.h
b/arch/arm/mach-
> xilinx/include/mach/uncompress.h
> > new file mode 100644
> > index 0000000..ff3754c
> > --- /dev/null
> > +++ b/arch/arm/mach-xilinx/include/mach/uncompress.h
> > @@ -0,0 +1,61 @@
> > +/* arch/arm/mach-xilinx/include/mach/uncompress.h
> > + *
> > + *  Copyright (C) 2011 Xilinx
> > + *
> > + * This software is licensed under the terms of the GNU General
Public
> > + * License version 2, as published by the Free Software Foundation,
and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef __MACH_UNCOMPRESS_H__
> > +#define __MACH_UNCOMPRESS_H__
> > +
> > +#include <mach/xilinx_soc.h>
> > +#include <mach/uart.h>
> > +#include <asm/processor.h>
> > +#include <asm/io.h>
> > +#include <mach/io.h>
> 
> You don't need mach/io.h here - it's already included by asm/io.h.
> It's probably also worth trying linux/io.h instead of asm/io.h too.

Makes sense, will incorporate that into next patch version.

Thanks,
John

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
