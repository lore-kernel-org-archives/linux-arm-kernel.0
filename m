From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 05 Jan 2017 18:33:08 +0900
Subject: [PATCH v2 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
In-Reply-To: <586E11FF.9080707@samsung.com>
References: <1483604833-29746-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170105082716epcas1p1f2a6eea40d842e2d8f7f7f54c029bc82@epcas1p1.samsung.com>
 <1483604833-29746-4-git-send-email-jcsing.lee@samsung.com>
 <586E0E56.6050608@samsung.com>
 <20170105092315.swensammin4wbgx5@gangnam.samsung>
 <586E11FF.9080707@samsung.com>
Message-ID: <20170105093308.ixefvxrfhhu2u2ir@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

> >> I add the some comment as following:
> >> - ldo23/25/31/38 have the different value between tm2 and tm2e.
> > 
> > Thanks for pointing this out. I planned to do this already in a
> > following patch as for now I think it's out from the scope of this
> > particular patch.
> 
> I think it is very simple work. If you want to make the common.dtsi,
> I think that you have to separate the different thing on each exynos5433-tm2X.dts.
> 
> > 
> >> - The patch[1] was alread posted. I think you better to rebase this patch on patch[1].
> >> [1] https://patchwork.kernel.org/patch/9491769/
> >> - ("ARM64: dts: TM2: comply to the samsung pinctrl naming convention")
> > 
> > Yes, I also thought about this, but I didn't know whether it was
> > already picked by anyone. I didn't want to stop Jaechul that's
> > why I was planning to rebase the other rather than this.
> > But you are right, because some bits of the other patches I know
> > that have been merged. Thank you!
> > 
> > Krzysztof, do you mind if I send patch 3 as a reply to this
> > e-mail? The changes should not affect patch 4, anyway.
> 
> No, If exynos5433-tm2.dts includes the different value of regulator,
> patch4 might be implemented based on patch3.

OK, I will re-work the patch 3 with the regulators and generate
again patch 4.

Thanks,
Andi
