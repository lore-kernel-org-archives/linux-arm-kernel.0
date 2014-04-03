From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 03 Apr 2014 11:12:08 +0900
Subject: [PATCH 02/10] ARM: EXYNOS: Correct file path in comment message
In-Reply-To: <533CBC18.8050106@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1396425058-4012-3-git-send-email-pankaj.dubey@samsung.com>
 <533BFC31.1080203@monstr.eu> <533CBC18.8050106@samsung.com>
Message-ID: <00f301cf4ee2$1f2445c0$5d6cd140$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pankaj Dubey wrote:
> 
> Hi Michal,
> 
> On 04/02/2014 09:01 PM, Michal Simek wrote:
> > On 04/02/2014 09:50 AM, Pankaj Dubey wrote:
> >> This patch corrects file path mentioned in file comment message.
> >>
> >> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> >> ---
> >>   arch/arm/mach-exynos/platsmp.c |    2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-
> exynos/platsmp.c
> >> index 03e5e9f..d8d1555 100644
> >> --- a/arch/arm/mach-exynos/platsmp.c
> >> +++ b/arch/arm/mach-exynos/platsmp.c
> >> @@ -1,4 +1,4 @@
> >> -/* linux/arch/arm/mach-exynos4/platsmp.c
> >> +/* linux/arch/arm/mach-exynos/platsmp.c
> >>    *
> >>    * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
> >>    *		http://www.samsung.com
> >>
> > Shouldn't you just remove it entirely?
> > I had the same file names in the whole microblaze tree
> > and some months/years later this was just broken everywhere.
> > That's why it is just easier to remove it entirely.
> 
> Thanks for review and suggestion.
> Removing of file name makes more sense to me also.
> Will take care of this in some other files also under "mach-exynos"
> in next version of patch.
> 
No, basically don't need it.

And Sachin/Tushar have posted it before, I didn't agree at that time though.

- Kukjin
