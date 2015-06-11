From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 11 Jun 2015 14:41:45 -0700
Subject: [GIT PULL 4/5] Samsung another DT updates for v4.2
In-Reply-To: <5571E4E4.1070900@kernel.org> (Kukjin Kim's message of "Sat, 06
 Jun 2015 03:05:24 +0900")
References: <5571E4E4.1070900@kernel.org>
Message-ID: <7hr3phdism.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim <kgene@kernel.org> writes:

> Hi,
>
> Here is another Samsung DT updates for v4.2 but this is based on
> v4.1-rc6 + previous tags/samsung-dt-3 because this touches all of exynos
> DT stuff and some fixes have been merged until -rc6...

In the future, it would be helpful to describe what fixes from -rc6 this
series depends on.

> I thought this is the best way to avoid useless merge conflicts.
>
> Please pull and if any problems, please kindly let me know.
>
> Thanks,
> Kukjin
>
>
> The following changes since commit b9974fa208d9175a6d1d21f6b1068e1779295934:
>
>   Merge branch 'v4.2-next/dt-samsung-3rd' into v4.2-next/dt-samsung-4th
> (2015-06-03 09:56:00 +0900)
>
> are available in the git repository at:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-dt-4
>
> for you to fetch changes up to b7004516781503c0e4782288025ca2ce4a78f020:
>
>   ARM: dts: add sysmmu nodes for exynos5420 (2015-06-04 08:09:42 +0900)
>
> ----------------------------------------------------------------
> Samsung another DT udpates for v4.2
>
> - use labels for overriding nodes for all of exynos stuff
>   (by Krzysztof Kozlowski)
>
> - add sysmmu nodes for exynos SoCs (by Marek Szyprowski)
>
> - for exynos5422-odroidxu3
>   : enalbe wake alarm of S2MPS11 RTC
>   : Hook up PWM and use it for LEDs
>   : add support for Odroid XU3 Lite
>
> - remove duplicated i2c7 for exynos5250-snow
> - add JPEG codec nodes for exynos5420
> - add vendor prefix for Hardkernel
>
> ----------------------------------------------------------------

Pulled into next/dt,

Thanks,

Kevin
