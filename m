From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 17:52:16 +0100
Subject: [GIT PULL 3/3] ARM: defconfig: exynos: config for v4.16
In-Reply-To: <20171220173643.5840-2-krzk@kernel.org>
References: <20171220173643.5840-1-krzk@kernel.org>
 <20171220173643.5840-2-krzk@kernel.org>
Message-ID: <CAK8P3a2ZtNmk0pzd-3THPSL42PzsQU-P8PoJ2BqBEyymmYBdDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 6:36 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.16
>
> for you to fetch changes up to 6b732dfb698991b5f518be1ddf329c1c2eb3d7cb:
>
>   ARM: exynos_defconfig: Enable CONFIG_EXYNOS_IOMMU (2017-12-14 18:57:38 +0100)
>
> ----------------------------------------------------------------
> Samsung defconfig changes for v4.16
>
> 1. Enable missing drivers for supported Exynos boards (PMU, CEC, MHL
>    bridge, ASoC for Odroid XU3/XU4).
> 2. Enable Exynos IOMMU driver on exynos_defconfig.

Pulled into next/soc, thanks!

        Arnd
