From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 Aug 2013 08:52:33 -0700
Subject: [GIT PULL 2/2] Samsung Exynos DT for v3.12
In-Reply-To: <160101ce9c63$31b146c0$9513d440$%kim@samsung.com> (Kukjin Kim's
 message of "Mon, 19 Aug 2013 07:35:08 +0900")
References: <160101ce9c63$31b146c0$9513d440$%kim@samsung.com>
Message-ID: <8738q1u3i6.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim <kgene.kim@samsung.com> writes:

> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
>
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-dt-1
>
> for you to fetch changes up to 6f9d02a056fff8e965da0f940a09d4c39a4fe80a:
>
>   ARM: dts: Add USB host node for Exynos4 (2013-08-19 05:07:17 +0900)
>
> ----------------------------------------------------------------
> Samsung Exynos DT updates for v3.12
> - update codec, pmic, usb hub for Arndale
> - add exynos4412-trats 2 board dt
> - update camera, spi, sensor for Trats2
> - update fimc, sensor for Trats
> - add support tmu for exynos5440
> - add support g2d for exynos5250
> - correct camera pinctrl for exynos4x12
> - add support camera subsystem for exynos4
> - add support basic pm domain, fimd, dp for exynos5420
> - add support secure-firmware for OrigenQuad
> - update mfc and add support mfc for exynos5420
> - add usb host node for exynos4

Pulled into next/dt,

Kevin
