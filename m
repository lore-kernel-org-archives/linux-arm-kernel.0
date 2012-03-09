From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 09 Mar 2012 09:30:30 -0700
Subject: Subject: [PATCH] MAINTAINERS: add maintainer entry for SAMSUNG
 EXYNOS DeviceTree
In-Reply-To: <CAJuYYwSqGDmuXrtBscCSFoQEOpWCQ-1H+2dHxeUYny7KwUPLOg@mail.gmail.com>
References: <00f301ccf0f7$39f222a0$add667e0$%kim@samsung.com>
 <CAJuYYwSqGDmuXrtBscCSFoQEOpWCQ-1H+2dHxeUYny7KwUPLOg@mail.gmail.com>
Message-ID: <20120309163030.661F93E0880@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Feb 2012 07:49:18 +0530, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> On 22 February 2012 05:46, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Add Samsung EXYNOS DT maintainer
> >
> > Cc: Thomas Abraham <thomas.abraham@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > ??MAINTAINERS | ?? 10 ++++++++++
> > ??1 files changed, 10 insertions(+), 0 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9a648eb..5ac5aaf 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1065,6 +1065,16 @@ S: ?? ?? ?? Maintained
> > ??F: ?? ?? arch/arm/mach-s5p*/
> > ??F: ?? ?? arch/arm/mach-exynos*/
> >
> > +ARM/SAMSUNG EXYNOS DEVICE TREE
> > +M: ?? ?? Thomas Abraham <thomas.abraham@linaro.org>
> > +M: ?? ?? Kukjin Kim <kgene.kim@samsung.com>
> > +L: ?? ?? devicetree-discuss at lists.ozlabs.org (moderated for non-subscribers)
> > +L: ?? ?? linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
> > +S: ?? ?? Maintained
> > +F: ?? ?? arch/arm/boot/dts/exynos*
> > +F: ?? ?? arch/arm/mach-exynos/*dt.c
> > +F: ?? ?? Documentation/devicetree/*/*/*samsung*
> > +
> 
> Acked-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>
