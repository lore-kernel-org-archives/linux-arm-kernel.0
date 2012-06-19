From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 19 Jun 2012 17:58:35 +0900
Subject: [PATCH] ARM: exynos: enable more platforms in defconfig
In-Reply-To: <1338784735-10683-1-git-send-email-olof@lixom.net>
References: <1338784735-10683-1-git-send-email-olof@lixom.net>
Message-ID: <01a601cd4df9$b5aece20$210c6a60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
Hi Olof,

Sorry for late reply on this, I came back from travelling, anyway.

> This enables the new EXYNOS5 platforms in the defconfig, and enables DT
> support on EXYNOS4.
> 
Yes, agree, it's time to move on new defconfig for supporting DT.

> While I'm at it, I renamed it exynos4_defconfig -> exynos_defconfig,
> since it now encompasses all (known and supported) versions of exynos.
> 
OK, basically looks good to me. But how about keeping exynos4_defconfig for
non-DT and creating exynos_defconfig for supporting DT on EXYNOS4 and
EXYNOS5? Of course, we can remove exynos4_defconfig after finishing of
EXYNOS DT later.

> Other options enabled: USB host, EXT3/4, regulators and tps65090,
> networking and a few of the common usb ethernet adapters as well as the
> smsc911x controller used on some boards.
> 
> I enabled EFI_PARTITION, since it's used on some filesystem images I'm
> using. I didn't see a need to keep Solaris and BSD partition format
> still enabled.
> 
> Finally, framebuffer console, logo and fonts were enabled.
> 
> Note that enabling some of these options introduces build coverage
> previously missing, thus introducing a few build errors and warnings
> for which fixes have been sent out already.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/configs/exynos4_defconfig | 68 --------------------------
>  arch/arm/configs/exynos_defconfig  | 98
> ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+), 68 deletions(-)
>  delete mode 100644 arch/arm/configs/exynos4_defconfig
>  create mode 100644 arch/arm/configs/exynos_defconfig
> 

[...]


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
