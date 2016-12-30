From: andi@etezian.org (Andi Shyti)
Date: Sat, 31 Dec 2016 05:28:43 +0900
Subject: [PATCH v2 3/4] ARM64: dts: exynos5433: use macros for pinctrl
 configuration on Exynos5433
In-Reply-To: <CACRpkdaz9AyFJs1Th_SVexqKaP-=iPF0G-1YXOCoSmrQH8ZHDA@mail.gmail.com>
References: <CGME20161230041427epcas1p1151d6e28fac143c63efaf4f7c8ed432d@epcas1p1.samsung.com>
 <20161230041421.24448-1-andi.shyti@samsung.com>
 <20161230041421.24448-4-andi.shyti@samsung.com>
 <CACRpkdaz9AyFJs1Th_SVexqKaP-=iPF0G-1YXOCoSmrQH8ZHDA@mail.gmail.com>
Message-ID: <20161230202843.qac5fziejog2yghh@jack.zhora.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> > Use the macros defined in include/dt-bindings/pinctrl/samsung.h
> > instead of hardcoded values.
> >
> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> 
> These look fine, but that this and the other DTS patch through ARM SoC.
> 
> If you also need the headerfile patch (patch 2) to go through ARM SoC
> that is fine,
> I can take it out of pinctrl if you want.

yes, sure... no problem from my side :)

Thanks,
Andi
