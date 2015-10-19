From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Mon, 19 Oct 2015 22:06:25 +0530
Subject: [PATCH 0/7] Switch to generic syscon regmap based drivers
In-Reply-To: <56251561.4010209@math.uni-bielefeld.de>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
 <56251561.4010209@math.uni-bielefeld.de>
Message-ID: <CAGOxZ53YiHjdMNhvu4YMwaOEg+Kt2iOW5M9u_pj-0BUpMbgDdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tobias,

On Mon, Oct 19, 2015 at 9:38 PM, Tobias Jakobi
<tjakobi@math.uni-bielefeld.de> wrote:
> Hello Alim,
>
> I tested the Exynos4 bits on a Odroid-X2 and I can confirm that
> poweroff/reboot (still) work.
>
Thanks for helping out in testing, will add your Tested-by of patch 2/7.

> With best wishes,
> Tobias
>
>
> Alim Akhtar wrote:
>> Alim Akhtar (7):
>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos3250 SoCs
>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos4
>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5
>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 SoC
>>   ARM: exynos_defconfig: Normalize exynos defconfig
>>   ARM: exynos_defconfig: Enable generic syscon-{reboot, poweroff}
>>     drivers
>>   ARM: EXYNOS: Remove code for restart and poweroff for exynos SoCs
>>
>>  arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++
>>  arch/arm/boot/dts/exynos4.dtsi    |   14 ++++++++++++
>>  arch/arm/boot/dts/exynos5.dtsi    |   14 ++++++++++++
>>  arch/arm/boot/dts/exynos5410.dtsi |   14 ++++++++++++
>>  arch/arm/configs/exynos_defconfig |   11 +++++-----
>>  arch/arm/mach-exynos/pmu.c        |   43 -------------------------------------
>>  6 files changed, 61 insertions(+), 49 deletions(-)
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
