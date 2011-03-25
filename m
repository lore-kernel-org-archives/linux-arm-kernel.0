From: John.Linn@xilinx.com (John Linn)
Date: Fri, 25 Mar 2011 11:09:52 -0600
Subject: multiple definition of `show_mem'
In-Reply-To: <4D8C7750.5070102@pengutronix.de>
References: <4D8B6140.4020300@pengutronix.de><alpine.DEB.2.00.1103241522230.26730@chino.kir.corp.google.com>
	<4D8C7750.5070102@pengutronix.de>
Message-ID: <4dc8fdc5-b255-4c26-93ec-8be5056f8646@VA3EHSMHS001.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org
[mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Marc Kleine-Budde
> Sent: Friday, March 25, 2011 5:07 AM
> To: David Rientjes
> Cc: linux-arm-kernel; LKML; kernel at pengutronix.de
> Subject: Re: multiple definition of `show_mem'
> 
> On 03/24/2011 11:22 PM, David Rientjes wrote:
> >> current mainline (v2.6.38-7210-gb81a618) on ARM/mxs has the
following build failure:
> >>
> >>> lib/lib.a(show_mem.o): In function `show_mem':
> >>> .../linux-2.6/lib/show_mem.c:67: multiple definition of `show_mem'
> >>> arch/arm/mm/built-in.o:.../linux-2.6/arch/arm/mm/init.c:82: first
> >>> defined here
> >>> make: *** [vmlinux.o] Error 1
> 
> [..]
> 
> > Sorry about that, Marc.  I have a patch at
> >
> > 	http://marc.info/?l=linux-kernel&m=130100511521954
> >
> > which should fix the issue for you (and I tested it with my arm
cross
> > compiler).
> 
> \o/ - the patch is already in mainline, boots like charm on my
mx28evk.

I pulled it, rebuilt without any issues, and it runs also on the Xilinx
platform.

Thanks,
John

> 
> regards, Marc
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
