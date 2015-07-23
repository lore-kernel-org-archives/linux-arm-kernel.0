From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 23 Jul 2015 17:15:01 +0900
Subject: [GIT PULL] Samsung 1st fixes for v4.2
In-Reply-To: <20150721210542.GA13353@localhost>
References: <55ADBF14.30304@kernel.org> <20150721210542.GA13353@localhost>
Message-ID: <02fb01d0c51f$ac4649d0$04d2dd70$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> Hi Kukjin,
> 
Hi Olof,

> On Tue, Jul 21, 2015 at 12:40:04PM +0900, Kukjin Kim wrote:
> > Hi,
> >
> > Please pull samsung fixes for v4.2.
> >
> > Thanks,
> > Kukjin
> >
> > The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> >
> >   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/samsung-fixes-1
> >
> > for you to fetch changes up to 300bde79f3d86b1af6fcde7b7b2439ecffccbff4:
> >
> >   ARM: dts: add CPU OPP and regulator supply property for exynos4210
> > (2015-07-21 12:32:29 +0900)
> 
> Was there a reason you rebased Krzystztof's branch? The contents is identical.
> 
> In cases like those, feel free to just forward the pull request to us
> and we can do it directly. If you have more patches you want to add into
> the same fixes branch then you can just merge his in and apply yours on
> top. That's for example how Tony Lindgren tends to handle OMAP -- he'll
> forward a pull request from Paul Walmsley if that's the only contents
> he has.
> 
Yeah, I know what you're saying and I agreed. Actually the OMAP model would be
helpful. BTW in this case, I wanted to change the subject title that's why I
did cherry-pick.

> Anyway, merged.
> 
Thanks,
Kukjin
