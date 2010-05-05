From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 5 May 2010 15:02:00 +0530
Subject: [PATCH v8 0/2] sDMA descriptor autoloading feature
In-Reply-To: <q2r618f0c911005042138t81e86b09g444d2772ddc30b29@mail.gmail.com>
References: <i2x618f0c911004291034g7f5b377ds5efaf74c901bc036@mail.gmail.com>
	<00ea01caebdf$affcb8d0$544ff780@am.dhcp.ti.com>
	<q2r618f0c911005042138t81e86b09g444d2772ddc30b29@mail.gmail.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D0@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: svenkatr at gmail.com [mailto:svenkatr at gmail.com] On Behalf Of S, Venkatraman
> Sent: Wednesday, May 05, 2010 10:09 AM
> To: Chikkature Rajashekar, Madhusudhan
> Cc: linux-omap at vger.kernel.org; linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Tony
> Lindgren; Adrian Hunter; Shilimkar, Santosh
> Subject: Re: [PATCH v8 0/2] sDMA descriptor autoloading feature
> 
> On Wed, May 5, 2010 at 4:45 AM, Madhusudhan <madhu.cr@ti.com> wrote:
> >> -----Original Message-----
> >> From: svenkatr at gmail.com [mailto:svenkatr at gmail.com] On Behalf Of
> >> Venkatraman S
> >> Sent: Thursday, April 29, 2010 12:35 PM
> >> To: linux-omap at vger.kernel.org; linux-mmc at vger.kernel.org; linux-arm-
> >> kernel at lists.infradead.org
> >> Cc: Madhusudhan Chikkature; Tony Lindgren; Adrian Hunter; Santosh
> >> Shilimkar
> >> Subject: [PATCH v8 0/2] sDMA descriptor autoloading feature
> >>
> >> ? ? This patch series is the introduction of new sDMA feature: descriptor
> >> autoloading (v8) and it's adoption by the OMAP HSMMC driver.
> >>
> >> ? ?The previous version (v7) was blocked on achieving proper interrupt
> >> syncronisation
> >> between the MMC and DMA callback in the HSMMC driver.
> >> ? Thanks to Adrian Hunter's patch,
> >> https://patchwork.kernel.org/patch/94670/
> >> this has been cleaned up.
> >>
> >> Current version is based on for-next branch + Adrian Hunter's
> >> interrupt syncronisation patch
> >> (https://patchwork.kernel.org/patch/94670)
> >>
> >> Changes since v7:
> >> ? * Removed the 'fix race condition between DMA and HSMMC callback'
> >> part of the series
> >> ? * Added memory barries in start and resume sglist transfer for cpu
> >> buffer syncronization
> >> ? * Cleanup and comments
> >>
> >> This has been tested on OMAP3430, OMAP3630 and OMAP4430 SDP
> >> for MMC file transfer and as boot file system.
> >>
> >
> > The HSMMC driver changes look good to me. I can ACK that but am not a DMA
> > expert to review your changes to the DMA driver.
> >
Venkat, 
Sorry for late comments on your series.
 
