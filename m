From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:42:07 -0800
Subject: [PATCH] ARM: EXYNOS: fix uncompress.h and debug-macro.S for
 EXYNOS5440
In-Reply-To: <CAK9yfHycpk6S1e3wW-8hLB7HM2tFykZGOSiz2jaYVwMf2khOUA@mail.gmail.com>
References: <1356632834-8934-1-git-send-email-kgene.kim@samsung.com>
 <CAK9yfHycpk6S1e3wW-8hLB7HM2tFykZGOSiz2jaYVwMf2khOUA@mail.gmail.com>
Message-ID: <042601cde93a$662750c0$3275f240$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat wrote:
> 
> Hi Kukjin,
> 
Hi,

> On 27 December 2012 23:57, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > This patch fixes uart base address for uncompress and debug-macro
> > on EXYNOS5440.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  arch/arm/mach-exynos/include/mach/debug-macro.S |   25
> +++++++++++++++++------
> >  arch/arm/mach-exynos/include/mach/map.h         |    1 +
> >  arch/arm/mach-exynos/include/mach/uncompress.h  |   20
> +++++++++++-------
> >  3 files changed, 33 insertions(+), 13 deletions(-)
> 
> With this patch I found that Origen board does not boot.
> It stops at "Uncompressing Linux...".
> Tested using your latest for-next branch.
> 
Oh, OK. Let me check it again.
Thanks for your test.

Happy New Year!

- Kukjin
