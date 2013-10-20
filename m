From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Oct 2013 06:34:29 +0900
Subject: [PATCH V2] ARM: EXYNOS: Move arm core power down clock to
 exynos5250 common clock
In-Reply-To: <4953642.S7P9jyspGP@amdn883>
References: <1381470134-29410-1-git-send-email-amit.daniel@samsung.com>
 <4953642.S7P9jyspGP@amdn883>
Message-ID: <52644C65.3040805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/13 16:33, Tomasz Figa wrote:
> Hi Amit,
>
> On Friday 11 of October 2013 11:12:14 Amit Daniel Kachhap wrote:
>> Now with common clock support added for exynos5250 it is necessary to move
>> this code to exynos5250 common clock driver as clock registers should be
>> handled there. This change is tested in exynos5250 based arndale platform.
>>
>> Cc: Abhilash Kesavan<a.kesavan@samsung.com>
>> Cc: Thomas Abraham<thomas.abraham@linaro.org>
>> Acked-by: Kukjin Kim<kgene.kim@samsugn.com>
>
> nit: Typo in samsung. Probably something that Kukjin can fix up when
> applying, though.
>
>> Reviewed-by: Bartlomiej Zolnierkiewicz<b.zolnierkie@samsung.com>
>> Signed-off-by: Amit Daniel Kachhap<amit.daniel@samsung.com>
>> ---
>>
>> Changes in V2:
>> * Rebased against linux-next tree.
>> * Removed un-used macros in regs-clock.h
>>
>>   arch/arm/mach-exynos/cpuidle.c                 |   35 --------------------
>>   arch/arm/mach-exynos/include/mach/regs-clock.h |   16 ---------
>>   drivers/clk/samsung/clk-exynos5250.c           |   42 ++++++++++++++++++++++++
>>   3 files changed, 42 insertions(+), 51 deletions(-)
>
> Otherwise
>
> Acked-by: Tomasz Figa<t.figa@samsung.com>
>
Mike, do you want me to pick this patch into Samsung tree?

- Kukjin
