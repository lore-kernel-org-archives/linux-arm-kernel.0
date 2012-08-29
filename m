From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 29 Aug 2012 15:52:23 +0200
Subject: [PATCH 1/3] ARM: EXYNOS: Use EXYNOS4210_GPEx instead of
 EXYNOS4_GPEx
In-Reply-To: <CAH9JG2UF6cqPcX4idYLRBHwLvs27ErtbwsjEFvMZbyfz_KNsZw@mail.gmail.com>
References: <4648723.rWnut7F0uJ@amdc1227> <503D57EF.2090402@samsung.com>
 <CAH9JG2UF6cqPcX4idYLRBHwLvs27ErtbwsjEFvMZbyfz_KNsZw@mail.gmail.com>
Message-ID: <3351890.rVcxVBV0WB@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 29 of August 2012 09:03:12 Kyungmin Park wrote:
> On 8/29/12, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Please see my comments on Joonyoung Shim's previous patch...
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/101522.h
> > tml
> It's perference issue. some person like this style. others doesn't.
> Moreever vender, System LSI, provided codes have whole different style.
> It lists up whole gpios for each SoCs.
> 
> EXYNOS4210_{A0, .... Z}
> EXYNOS4412_{A0, .... V4}
> EXYNOS5250_{A0, .... Z}
> 
> anyway, just remain it as broken, and try to use pinctl as Thomas
> mentioned.

OK, I will drop this patchset for the time being. Let's get the pinctrl 
driver merged first and then investigate Exynos4x12 support in it.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
