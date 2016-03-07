From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 Mar 2016 05:29:29 +0100
Subject: [PATCH 0/4] ARM64:SoC add a new platform, LG Electronics's lg1k
In-Reply-To: <1457323800-26904-1-git-send-email-chanho.min@lge.com>
References: <1457323800-26904-1-git-send-email-chanho.min@lge.com>
Message-ID: <201603070529.29680.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 March 2016, Chanho Min wrote:
> This is an initial series for supporting LG Electronics's lg1k SoCs,
> based on ARM Cortex-A53, mainly used for digital TVs.
> 
> Chanho Min (4):
>   arm64: add Kconfig entry for LG1K SoC family
>   arm64: defconfig: enable ARCH_LG1K
>   arm64: dts: Add dts files for LG Electronics's lg1312 SoC
>   MAINTAINERS: add myself as ARM/LG1K maintainer

The patches look ok in principle, but the timing is unfortunate: we are at -rc7 now,
just before the merge window, and we need to give this a little extra time for review,
so I think we should merge this for 4.7, not 4.6.

	Arnd
