From: riverful.kim@samsung.com (HeungJun, Kim)
Date: Fri, 27 Jan 2012 17:24:43 +0900
Subject: [PATCH V1] ARM: EXYNOS: Adds Samsung TRATS board support
In-Reply-To: <019e01ccdcaf$aa0518b0$fe0f4a10$%kim@samsung.com>
References: <1324966676-5714-1-git-send-email-riverful.kim@samsung.com>
 <028701ccc5da$31491fc0$93db5f40$%kim@samsung.com>
 <000f01ccc5de$df5987e0$9e0c97a0$%kim@samsung.com>
 <019e01ccdcaf$aa0518b0$fe0f4a10$%kim@samsung.com>
Message-ID: <004d01ccdccd$1f49d300$5ddd7900$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin Kim,

Sure. I submitted the patch rebased on v3.3_rc1.
The patch's version prefix was some vague, so I just did not use to increment
the version.

Thank you.


Regards,
Heungjun Kim


> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Kukjin Kim
> Sent: Friday, January 27, 2012 1:54 PM
> To: 'HeungJun, Kim'
> Cc: kyungmin.park at samsung.com; linux-samsung-soc at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: [PATCH V1] ARM: EXYNOS: Adds Samsung TRATS board support
> 
> HeungJun, Kim wrote:
> >
> > Hi Kukjin Kim,
> >
> > > -----Original Message-----
> > > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-
> > > bounces at lists.infradead.org] On Behalf Of Kukjin Kim
> > > Sent: Thursday, December 29, 2011 12:30 PM
> > > To: 'HeungJun, Kim'
> > > Cc: kyungmin.park at samsung.com; linux-samsung-soc at vger.kernel.org; linux-
> > arm-
> > > kernel at lists.infradead.org
> > > Subject: RE: [PATCH V1] ARM: EXYNOS: Adds Samsung TRATS board support
> > >
> > > HeungJun, Kim wrote:
> > > >
> > > > This patch adds Samsung Mobile TRATS board support.
> > > >
> > > > The changes against V0:
> > > >   1) Modify Makefile & boardfile name: from "board-trats.c" to "mach-
> > > > trats.c"
> > > >   2) Fix name of mmc's fixed regulator: remove "inverted"
> > > >   3) Fix directory name on GPL comments: from "exynos4" to "exynos"
> > > >
> > > > Signed-off-by: HeungJun, Kim <riverful.kim@samsung.com>
> > > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > > ---
> > > >  arch/arm/mach-exynos/Kconfig      |   11 ++
> > > >  arch/arm/mach-exynos/Makefile     |    1 +
> > > >  arch/arm/mach-exynos/mach-trats.c |  340
> > > > +++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 352 insertions(+), 0 deletions(-)
> > > >  create mode 100644 arch/arm/mach-exynos/mach-trats.c
> > > >
> > > Hi HeungJun,
> > >
> > > Thanks for your re-submit.
> > >
> > > Hmm, maybe this is v2 not v1?
> > >
> > > Anyway, as I said, this conflicts with other ARM consolidation works. So
> > > please wait until after the merge window for this patch.
> > >
> > > Happy New Year.
> > This probably my mistake. v2 is right.
> > And it's no problem to be merge next windows. I'll wait.
> >
> > Happy new year, too!
> >
> Hi, could you please re-work this based on v3.3-rc1?
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
