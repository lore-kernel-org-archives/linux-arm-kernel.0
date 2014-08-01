From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 01 Aug 2014 07:16:27 +0200
Subject: [PATCH v5 00/10] ARM: dts: exynos: Prepare Spring
In-Reply-To: <1406868897-26874-1-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
Message-ID: <53DB22AB.6020007@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.08.2014 06:54, schrieb Andreas F?rber:
> Andreas F?rber (10):
>   ARM: dts: Fix MMC pinctrl for exynos5250-snow
>   ARM: dts: Fold exynos5250-cros-common into exynos5250-snow
>   ARM: dts: Clean up exynos5250-snow
>   ARM: dts: Fill in bootargs for exynos5250-snow
>   ARM: dts: Move dp_hpd from exynos5250 into smdk5250 and snow
>   ARM: dts: Clean up exynos5250-smdk5250
>   ARM: dts: Clean up exynos5250-arndale

>   ARM: dts: Fix apparent GPIO typo in exynos5250-arndale
>   ARM: dts: Simplify USB3503 on exynos5250-arndale

Note that these two are again untested! They are entirely optional.

Andreas

>   ARM: dts: Add exynos5250-spring device tree
> 
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/exynos5250-arndale.dts      | 927 +++++++++++++-------------
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi | 164 -----
>  arch/arm/boot/dts/exynos5250-pinctrl.dtsi     |   7 -
>  arch/arm/boot/dts/exynos5250-smdk5250.dts     | 641 +++++++++---------
>  arch/arm/boot/dts/exynos5250-snow.dts         | 441 +++++++-----
>  arch/arm/boot/dts/exynos5250-spring.dts       | 536 +++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi             |  24 +-
>  8 files changed, 1624 insertions(+), 1117 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/exynos5250-cros-common.dtsi
>  create mode 100644 arch/arm/boot/dts/exynos5250-spring.dts

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
