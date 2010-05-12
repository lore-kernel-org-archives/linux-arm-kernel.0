From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 12 May 2010 07:22:11 +0200
Subject: [PATCH 04/16] ARM: S5PC100: copy clocks from plat-s5pc1xx
In-Reply-To: <001401caf18f$5932f6d0$0b98e470$%kim@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-5-git-send-email-m.szyprowski@samsung.com>
	<001401caf18f$5932f6d0$0b98e470$%kim@samsung.com>
Message-ID: <002901caf193$15120730$3f361590$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, May 12, 2010 6:55 AM Kukjin Kim wrote:

> Marek Szyprowski wrote:
> >
> > Prepare for moving support for S5PC100 SoC to plat-s5p framework (part 2).
> Copy
> > clocks definition to mach-s5pc100 directory.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  .../s5pc100-clock.c => mach-s5pc100/clock.c}       |    0
> >  1 files changed, 0 insertions(+), 0 deletions(-)
> >  copy arch/arm/{plat-s5pc1xx/s5pc100-clock.c => mach-s5pc100/clock.c}
> (100%)
> >
> > diff --git a/arch/arm/plat-s5pc1xx/s5pc100-clock.c
> b/arch/arm/mach-s5pc100/clock.c
> > similarity index 100%
> > copy from arch/arm/plat-s5pc1xx/s5pc100-clock.c
> > copy to arch/arm/mach-s5pc100/clock.c
> > --
> 
> How about change the comment in the head of moving file.
> 
> And where is the patch for arch/arm/plat-s5pc1xx/clock.c?
> I couldn't find it except 01_patch which just changes naming.

arch/arm/plat-s5pc1xx/clock.c file is removed in the last patch of this
series ("ARM: remove obsolete plat-s5pc1xx directory"). Again I split
this into separate patches to generate diffs that are easier to follow.
This also made it possible not to break compilation of the kernel between
the patches.

The real changes to that code is performed in the "ARM: S5PC100: new
clocks definition" patch.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
