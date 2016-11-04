From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 04 Nov 2016 12:19:49 +0100
Subject: [PATCH 10/13] ARM: dts: exynos: replace to "max-frequecy" instead
 of "clock-freq-min-max"
In-Reply-To: <ecf4fac2-0ab7-d4c4-69e3-d498ee5b601c@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
 <20161103184112.GB11071@kozik-lap>
 <ecf4fac2-0ab7-d4c4-69e3-d498ee5b601c@samsung.com>
Message-ID: <4066252.a1W9ejEKHX@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jaehoon,

Am Freitag, 4. November 2016, 19:21:30 CET schrieb Jaehoon Chung:
> On 11/04/2016 03:41 AM, Krzysztof Kozlowski wrote:
> > On Thu, Nov 03, 2016 at 03:21:32PM +0900, Jaehoon Chung wrote:
> >> In drivers/mmc/core/host.c, there is "max-frequency" property.
> >> It should be same behavior. So Use the "max-frequency" instead of
> >> "clock-freq-min-max".
> >> 
> >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >> ---
> >> 
> >>  arch/arm/boot/dts/exynos3250-artik5-eval.dts | 2 +-
> >>  arch/arm/boot/dts/exynos3250-artik5.dtsi     | 2 +-
> >>  arch/arm/boot/dts/exynos3250-monk.dts        | 2 +-
> >>  arch/arm/boot/dts/exynos3250-rinato.dts      | 2 +-
> >>  4 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > This looks totally independent to rest of patches so it can be applied
> > separately without any functional impact (except lack of minimum
> > frequency). Is that correct?
> 
> You're right. I will split the patches. And will resend.
> Thanks!

I think what Krzysztof was asking was just if he can simply pick up this patch 
alone, as it does not require any of the previous changes.

Same is true for the Rockchip patches I guess, so we could just take them 
individually into samsung/rockchip dts branches.


Heiko
