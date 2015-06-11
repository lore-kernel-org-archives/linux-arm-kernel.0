From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 11 Jun 2015 14:50:20 -0700
Subject: [GIT PULL 3/5] Samsung DT updates for v4.2
In-Reply-To: <5571E4CB.3070302@kernel.org> (Kukjin Kim's message of "Sat, 06
 Jun 2015 03:04:59 +0900")
References: <5571E4CB.3070302@kernel.org>
Message-ID: <7hh9qddieb.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim <kgene@kernel.org> writes:

> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
>
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-dt-3
>
> for you to fetch changes up to 5ec1d441a4227b2dfdc47fdc13aa7c6c50496194:
>
>   ARM: dts: Add syscon property to the MIPI DPHY for exynos4415
> (2015-06-03 09:47:05 +0900)
>
> ----------------------------------------------------------------
> Samsung DT updates for v4.2
>
> - for exyos3250
>   : use s3c6410-rtc instead of exynos3250-rtc
>   : add JPEG codec node and support it on exynos3250-rinato
>   : use s3c-rtc clock id for exynos3250-rinato and monk boards
>
> - for exynos4
>   : add JPEG codec node and syscon property to MIPI DPHY
>   : remove obsolete MIPI DPHY reg property
>   : enable s3c-rtc on exynos4412-trats2
>
> - for exynos5
>   : add syscon property to MIPI DPHY for exynos5420
>   : enable s3c-rtc on exynos5420-arndale-octa
>   : add missing irq pinctrl for max77686 on exynos5250-smdk5250
>
>   : clk: add bindings for 32kHz clocks from s2mps11
>   : fix pinctrl for s2mps11-irq on exynos5420-arndale-octa
>
> - for exynos5422-odroidxu3
>   : add mmc detect gpio and LEDs
>   : add HS400 support, simple-audio-card and rtc_src clock
>
> ----------------------------------------------------------------

Pulled into next/dt.

Thanks,

Kevin
