From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Wed, 30 Oct 2013 00:32:01 +0530
Subject: [Patch v4 0/2] Enable all cpus in Exynos5420
In-Reply-To: <1381119431-12697-1-git-send-email-chander.kashyap@linaro.org>
References: <1381119431-12697-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <CANuQgHEx+pNdaybeJ_dpQ5kWYpA44hrYj4ikW9d60a3hEZZPDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 7 October 2013 09:47, Chander Kashyap <chander.kashyap@linaro.org> wrote:
> Exynos5420 is an octa-core SoC. This patch series enables the remaining 4 cores.
>
> Changes in v2:
>         - Changed the cpu node @unit-address value to reg property value.
> Changes in v3:
>         - Removed leading 0x from @unit-address value.
> Changes in v4:
>         - Fixed typo and patch subject from "arm: dt" to "ARM: dt".
>
> Chander Kashyap (2):
>   clocksource: mct: extend mct to support 8 local interrupts for
>     Exynos5420
>   arm: dt: Exynos5420: populate cpu node enteries to 8 cpus
>
>  arch/arm/boot/dts/exynos5420.dtsi |   37 +++++++++++++++++++++++++++++++++++--
>  drivers/clocksource/exynos_mct.c  |    4 ++++
>  2 files changed, 39 insertions(+), 2 deletions(-)
>
> --
> 1.7.9.5
>

?

Can you please take these patches?

-- 
with warm regards,
Chander Kashyap
