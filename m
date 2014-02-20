From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 20 Feb 2014 02:58:29 +0000 (UTC)
Subject: [GIT PULL] ARM: OMAP2+: clock/PRCM/hwmod fixes for v3.14-rc
In-Reply-To: <53052219.9060109@ti.com>
References: <alpine.DEB.2.02.1402192120200.8777@utopia.booyaka.com>
 <53052219.9060109@ti.com>
Message-ID: <alpine.DEB.2.02.1402200257060.25798@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Feb 2014, Nishanth Menon wrote:

> Paul,
> On 02/19/2014 03:22 PM, Paul Walmsley wrote:
> [...]
> > 
> > - ----------------------------------------------------------------
> > Illia Smyrnov (1):
> >       ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4
> > 
> > Suman Anna (1):
> >       ARM: DRA7: hwmod data: correct the sysc data for spinlock
> > 
> > Tomi Valkeinen (1):
> >       ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT
> > 
> > Vaibhav Bedia (1):
> >       ARM: OMAP5: PRM: Fix reboot handling
> > 
> 
> https://patchwork.kernel.org/patch/3585321/ missing?

If that fixes a bug, then that should be documented in the commit 
description.

Otherwise it's 3.15 material.

- Paul
