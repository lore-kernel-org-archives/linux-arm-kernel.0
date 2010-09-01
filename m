From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Sep 2010 10:50:41 +0900
Subject: [PATCH 0/2] s3c: mach-real6410 missing fixes
In-Reply-To: <4C7B57F4.8010502@gmail.com>
References: <20100816173905.14924.62664.stgit@darius-desktop>
	<4C721CF0.3070004@gmail.com>
	<005b01cb45b2$7c4f5420$74edfc60$%kim@samsung.com>
	<4C7B57F4.8010502@gmail.com>
Message-ID: <012c01cb4978$193f67c0$4bbe3740$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Darius Augulis wrote:
> 
> Hi,
> 
Hi ;-)

> On 08/27/2010 09:38 AM, Kukjin Kim wrote:
> > Darius Augulis wrote:
> >>
> >> Hi Ben, Kukjin,
> >>
> > Hi Darius,
> >
> >> please add these patches to your tree, they contain necessary fixes for
> >> mach-real6410.
> >>
> > Looks good your patches.
> >
> > But I think, this should be sent to upstream through Ben's tree.
> >
> > If Ben has no time to handle this, I will do it through my tree.
> 
> it seems he hasn't. please pick up these two patches and older one, with
> fixup of device name of samsung serial. it hangs already for a long time
> without any comment.

I have a question about dm9000 on your real6410.

The smdkv210 use it also, but need to some modify dm9000 driver for use it.
Is there no problem on your board?

And please refer to my other comment about device name of Samsung serial.

Ben,
I will apply Darius' fixing CodingStyle patch.
If any problems, please let me know.

> 
> Darius.
> 
> >
> >> Darius.
> >>
> >>
> >> On 08/16/2010 08:43 PM, Darius Augulis wrote:
> >>> Two patches adding fixes that where in v2 of my
> >>> previous mach-real6410 patch series. These fixes are:
> >>>    * coding style errors reported by checkpatch.pl
> >>>    * irq flag in dm9000 pdata
> >>>
> >>> ---
> >>>
> >>> Darius Augulis (2):
> >>>         s3c: mach-real6410: fix coding style errors
> >>>         s3c: mach-real6410: add IORESOURCE_IRQ_HIGHLEVEL flag to
> >> dm9000
> >>>
> >>>
> >>>    arch/arm/mach-s3c64xx/mach-real6410.c |  104
> > +++++++++++++++++----------
> >> ------
> >>>    1 files changed, 52 insertions(+), 52 deletions(-)
> >>>
> >
> >


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
