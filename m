From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Fri, 24 Dec 2010 11:43:04 +0000
Subject: [alsa-devel] [PATCH 0/4] Modify configures to support Samsung
	ASoC dependancyless
In-Reply-To: <AANLkTim18YJH=FgCLruJKbyNeRM-zWFBBB6BaOoL-ajp@mail.gmail.com>
References: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
	<AANLkTim18YJH=FgCLruJKbyNeRM-zWFBBB6BaOoL-ajp@mail.gmail.com>
Message-ID: <1293190984.3291.5.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-12-24 at 16:56 +0900, Jassi Brar wrote:
> On Fri, Dec 24, 2010 at 3:26 PM, Seungwhan Youn <sw.youn@samsung.com> wrote:
> > Hi,
> >
> > These patches modify configuration to make audio support configurations on
> > platform(or arch) from sound/soc/samsung. This prevents that audio config
> > consider which board(or arch) can(or should) support ASoC audio driver, and
> > also prevents audio config dependancy on future Samsung SoCs.
> >
> >
> > These patches are modify below features:-
> >  o Add audio configurations on plat(or arch).
> >  o Modify audio configuration depends on plat(or arch) selection on ASoC.
> >
> > This patch-set is based on two different branches that :-
> >  o ARM patches are based on Kukjin Kim's git branch 'for-next'
> >   (commit id - 30fb9a94ec22435add3d2ea2d1b01c1a5ad6164c)
> >  o ASoC patches are based on Mark Brown's git branch 'for-next'
> >   (commit id - 722bc28384accb67c0bfbbe1914fd82d4d0c996a)
> >
> > This patch-set contains followings :-
> >  o To Kukjin Kim, Ben Dooks and Russell King,
> >  - [PATCH 1/4] ARM: Kconfig: Add audio support dependency
> >  - [PATCH 2/4] ARM: SAMSUNG: Add SMDK audio configuration
> >  o To Jassi Brar, Mark Brown and Liam Girdwood,
> >  - [PATCH 3/4] ASoC: SAMSUNG: Modify to indepedant depends on configuration
> >  - [PATCH 4/4] ASoC: SAMSUNG: Apply modifications for SMDK audio configuations
> 
> All,
> Acked-by : Jassi Brar <jassi.brar@samsung.com>

All 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
