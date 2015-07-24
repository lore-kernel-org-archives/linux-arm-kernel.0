From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 24 Jul 2015 12:40:32 +0900
Subject: [PATCH v6 0/3] cpufreq: Use cpufreq-dt driver for Exynos3250
In-Reply-To: <20150724003005.642.21781@quantum>
References: <1435797761-3339-1-git-send-email-cw00.choi@samsung.com>
 <4464631.oZyVO4Z0Ov@amdc1976> <093101d0b8c3$4b5d3ec0$e217bc40$@kernel.org>
 <20150724003005.642.21781@quantum>
Message-ID: <55B1B3B0.8090106@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/15 09:30, Michael Turquette wrote:
> Quoting Kukjin Kim (2015-07-07 07:43:31)
>> Bartlomiej Zolnierkiewicz wrote:

[...]

>>>> Chanwoo Choi (3):
>>>>   clk: samsung: exynos3250: Add cpu clock configuration data and instaniate cpu clock
>>>>   ARM: dts: Add CPU OPP and regulator supply property for Exynos3250
>>>>   ARM: exynos: Add exynos3250 compatible to use generic cpufreq driver
>>>>
>>>>  arch/arm/boot/dts/exynos3250-monk.dts   |  4 ++++
>>>>  arch/arm/boot/dts/exynos3250-rinato.dts |  4 ++++
>>>>  arch/arm/boot/dts/exynos3250.dtsi       | 15 +++++++++++++++
>>>>  arch/arm/mach-exynos/exynos.c           |  1 +
>>>>  drivers/clk/samsung/clk-exynos3250.c    | 32 ++++++++++++++++++++++++++++++--
>>>>  include/dt-bindings/clock/exynos3250.h  |  1 +
>>>>  6 files changed, 55 insertions(+), 2 deletions(-)
>>>
>>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>>
>>> Thank you for working on this.
>>>
>> +1 Thanks.
>>
>> Mike and Sylwester, if you're OK on this series, I'd like to pick up in Samsung
>> tree together. And if you want, I could provide topic branch for clk tree.
> 
> Kukjin,
> 
> A topic branch would be great.
> 
Sure, BTW it means you did 'ack' on this clk change? If not, please let
em know ;-) I'll let you know once the topic branch is ready.

Thanks,
Kukjin
