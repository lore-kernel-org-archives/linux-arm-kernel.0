From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 21:10:42 +0900
Subject: [PATCH] ARM: dts: exynos4: Use drive strength 3 for SD pins
In-Reply-To: <75197263.J0hoc8apCM@amdc1227>
References: <21831256.UCkQ5RyKd5@amdc1227> <1961860.xzxk1Exu2U@amdc1227>
 <0c8201cdc70f$a430a260$ec91e720$%kim@samsung.com>
 <75197263.J0hoc8apCM@amdc1227>
Message-ID: <0e7a01cdc7e1$3a83fd30$af8bf790$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Kgene,
> 
> On Tuesday 20 of November 2012 20:10:25 Kukjin Kim wrote:
> > Tomasz Figa wrote:
> > > Hi Kgene,
> > >
> > > On Tuesday 20 of November 2012 18:18:44 Kukjin Kim wrote:
> > > > Tomasz Figa wrote:
> > > > > This patch modifies pin control groups of SD pins on Exynos4210
> > > > > and
> > > > > Exynos4x12 to use drive strength 3, which corresponds to
> > > > > S5P_GPIO_DRVSTR_LV4 in legacy non-DT code.
> > > >
> > > > Well, the value of drive strength depends on board not SoC. So if
> > > > required, it should be moved to board DT stuff.
> > >
> > > Yes, I fully agree.
> > >
> > > I've been thinking whether to change the defaults or just override
> > > them
> > > for Origen, but I came to a conclusion that 3 (LV4) was the default in
> > > non-DT code, so it probably should be also the default in DT variant.
> >
> > OK.
> >
> > > > BTW, we can use the value as a default...I need to think about that
> > > > again for exynos4210 and 4x12.
> > >
> > > I wonder which default value is more appropriate, 0 or 3?
> >
> > In this case, yes, '3' is more useful...so can you re-submit this patch
> > with editing commit?
> 
> I can resubmit this patch, but I'm not sure what you expect me to edit.
> Could you explain?
> 
Hmm, I mean the commit message needs explanation is why to use '3' as a
default value is more useful. OK, if you don't mind, I will edit it when I
apply.

> If possible, it would be nice to get this included in 3.8 as it's required
> for Origen board to boot with device tree.
> 
OK, as we discussed, I agree with this.

Will apply, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
