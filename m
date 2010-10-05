From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 5 Oct 2010 10:45:29 +0530
Subject: [PATCH 02/14] omap: Map only available sram memory
In-Reply-To: <AANLkTi=wbRKvjTmVwE+Svx1SGS1HgAh74KcN_Y6Xwmin@mail.gmail.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=PM1x7zXbSMRxBHVZ5Z2+4iwebvbiGizca_rC8@mail.gmail.com>
	<20101001225303.GF3117@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE18C@dbde02.ent.ti.com>
	<AANLkTi=zmgSCCg71NsYMte9K-yeyb1i0VxCA4i_9Y8D-@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE61A@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE85B@dbde02.ent.ti.com>
	<AANLkTi=wbRKvjTmVwE+Svx1SGS1HgAh74KcN_Y6Xwmin@mail.gmail.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFEA56@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Grazvydas Ignotas [mailto:notasas at gmail.com]
> Sent: Tuesday, October 05, 2010 5:14 AM
> To: Shilimkar, Santosh
> Cc: Tony Lindgren; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Russell King - ARM Linux
> Subject: Re: [PATCH 02/14] omap: Map only available sram memory
> 
> > Looks like for you " is_sram_locked" function is failing. There was a
> patch
> > in my series from Vikram which was fixing this API.
> >
> > Do you have this patch applied when you are trying this out ?
> > http://www.spinics.net/linux/lists/arm-kernel/msg98697.html
> 
> Well it looks like this only happens on linux-next (was using
> next-20101001 version) with this defconfig:
> http://notaz.gp2x.de/misc/pnd/config_next_101001_2
> 
> this has yours and Vikram's patch you mentioned in. Using
> omap2plus_defconfig on linux-next or this "bad" defconfig on
> linux-omap boots fine, strange.
Indeed strange. At least good to know that omap2plus_defconfig
on linux-next is booting fine.
