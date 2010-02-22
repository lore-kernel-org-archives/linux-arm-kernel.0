From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2010 13:37:22 -0800
Subject: [PATCH 00/11] omap updates for 2.6.34, part 4
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C417FF19@dbde02.ent.ti.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C417FF19@dbde02.ent.ti.com>
Message-ID: <20100222213722.GU18786@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100220 00:27]:
> Tony, 
> 
> > -----Original Message-----
> > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Tony
> > Lindgren
> > Sent: Saturday, February 20, 2010 5:00 AM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: linux-omap at vger.kernel.org
> > Subject: [PATCH 00/11] omap updates for 2.6.34, part 4
> > 
> > Hi all,
> > 
> > Here are few USB platform init patches that have been already
> > posted to linux-usb and linux-omap and have been sitting in for-next.
> > 
> > Posting them one more time to make sure people on linux-arm-kernel
> > have seen these too.
> > 
> > Regards,
> > 
> > Tony
> > 
> > ---
> > 
> > Felipe Balbi (7):
> >       arm: omap: musb: ioremap only what's ours
> >       omap: musb: remove unused data
> >       arm: omap: musb: we can use clk framework
> >       omap: musb: remove unused soft_con field
> >       omap: musb: remove unused dma data
> >       omap: musb: remove unnecessary return
> >       omap: musb: get rid of dyn_fifo
> > 
> > Maulik Mankad (4):
> >       USB: Add empty functions in otg.h
> >       omap: musb: Remove #ifdef from board-omap3evm.c
> >       omap: musb: Pass board specific data from board file
> >       omap: musb: Add USB support to 4430 SDP board file
> >
> We need attached patch to keep multi-omap build booting on omap4
> on top of this series.

Thanks, I'll add it.

Tony
