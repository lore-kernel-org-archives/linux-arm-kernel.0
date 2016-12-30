From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 30 Dec 2016 17:17:24 +0200
Subject: [PATCH v2 3/4] ARM64: dts: exynos5433: use macros for pinctrl
 configuration on Exynos5433
In-Reply-To: <CACRpkdaz9AyFJs1Th_SVexqKaP-=iPF0G-1YXOCoSmrQH8ZHDA@mail.gmail.com>
References: <CGME20161230041427epcas1p1151d6e28fac143c63efaf4f7c8ed432d@epcas1p1.samsung.com>
 <20161230041421.24448-1-andi.shyti@samsung.com>
 <20161230041421.24448-4-andi.shyti@samsung.com>
 <CACRpkdaz9AyFJs1Th_SVexqKaP-=iPF0G-1YXOCoSmrQH8ZHDA@mail.gmail.com>
Message-ID: <20161230151724.5wlp4hbphasmw3rg@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 02:32:39PM +0100, Linus Walleij wrote:
> On Fri, Dec 30, 2016 at 5:14 AM, Andi Shyti <andi.shyti@samsung.com> wrote:
> 
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

Yes, I need the header. It would be much appreciated if you could
provide a tag or stable branch with it.

BTW, Andi, please follow the subject prefix convention (git log
--oneline arch/arm64/boot/dts/exynos).

Best regards,
Krzysztof
