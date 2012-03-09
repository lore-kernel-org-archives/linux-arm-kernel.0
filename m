From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 09 Mar 2012 07:33:01 -0800
Subject: [GIT PULL] Samsung Cleanup EXYNOS clock for v3.4
In-Reply-To: <CAOesGMiWOChuMjLQTK1pGys+oXCc4A=HO-2_=37rh3M6pgUP_g@mail.gmail.com>
References: <4F589474.8050609@samsung.com>
 <CAOesGMiWOChuMjLQTK1pGys+oXCc4A=HO-2_=37rh3M6pgUP_g@mail.gmail.com>
Message-ID: <4F5A22AD.1070907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/12 07:16, Olof Johansson wrote:
> Hi,
>
> On Thu, Mar 8, 2012 at 3:13 AM, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>
>> Kukjin Kim (2):
>>       ARM: EXYNOS: cleanup clock part for new EXYNOS SoCs
>
> This is one large commit that does many things in one change. As the
> patch message says:
>
> ARM: EXYNOS: cleanup clock part for new EXYNOS SoCs
>
> - the prefix of clk register replace S5P_ with EXYNOS4_
> - move mach-exynos/clock.c to mach-exynos/clock-exynos4.c
> - according to moving clock-exynos4.c,
>    move<mach/exynos4-clock.h>  to "clock-exynos4.h"
> - add prefix exynos4_ on clk declaration
>
> It makes it hard to review, especially when you combine a move with
> other changes. It's better to do the move in a separate commit that
> doesn't change code (or only changes very very little) and then do the
> other changes in separate commits later.
>
Hmm...OK, let me do as per your suggestion and will re-send this soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
