From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 8 Jun 2015 11:20:39 +0000
Subject: [PATCH v6] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <1432289414.27695.90.camel@x220>
References: <1432228025-6515-1-git-send-email-appanad@xilinx.com>
 <1432289414.27695.90.camel@x220>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A49A8CBA9@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,


> -----Original Message-----
> From: Paul Bolle [mailto:pebolle at tiscali.nl]
> Sent: Friday, May 22, 2015 3:40 PM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; vinod.koul at intel.com; Michal Simek; Soren
> Brinkmann; Appana Durga Kedareswara Rao; Punnaiah Choudary Kalluri;
> dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Srikanth Thokala
> Subject: Re: [PATCH v6] dma: Add Xilinx AXI Direct Memory Access Engine
> driver support
>
> Just a nit: a license mismatch.
>
> On Thu, 2015-05-21 at 22:37 +0530, Kedareswara rao Appana wrote:
> > --- /dev/null
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
>
> > + * This program is free software: you can redistribute it and/or
> > + modify
> > + * it under the terms of the GNU General Public License as published
> > + by
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
>
> This states the license is GPL v2 or later.
>
> > +MODULE_LICENSE("GPL v2");
>
> And, according to include/linux/module.h, this states the license is just GPL
> v2. So I think that either the comment at the top of this file or the ident used
> in the MODULE_LICENSE() macro needs to change.
>

Ok Will fix it in the next version of the patch.

Regards,
Kedar.

> Thanks,
>
>
> Paul Bolle



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
