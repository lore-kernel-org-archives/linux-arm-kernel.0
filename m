From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu, 3 Oct 2013 11:51:52 +0530
Subject: [PATCH v3 0/2] Enable all cpus in Exynos5420
In-Reply-To: <1378380593-5305-1-git-send-email-chander.kashyap@linaro.org>
References: <1378380593-5305-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <CANuQgHFbnkDnizH02-PR4qeq8+s7ZTq7Rv3bsJQHWia7xKPOEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 September 2013 16:59, Chander Kashyap <chander.kashyap@linaro.org> wrote:
> Exynos5420 is an octacore SoC. This patch series enables the remaining 4 cores.
>
> Changes in v2:
>         - Changed the cpu node @unit-address value to reg property value.
> Changes in v3:
>         - Removed leading 0x from @unit-address value.
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

Hi Kukjin, can you please take these patches.

-- 
with warm regards,
Chander Kashyap
