From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Sat, 7 Jul 2012 18:54:12 +0530
Subject: linux-next warning for arch/arm/mach-exynos/setup-usb-phy.c
In-Reply-To: <201207070857.45615.arnd@arndb.de>
References: <201207070857.45615.arnd@arndb.de>
Message-ID: <CAK9yfHzRPs5HGoegS9Rc4=cXY6nSnyP_akJvnvV9bK=_68B5tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for pointing it out.
I will send the fix on Monday.

On 7 July 2012 14:27, Arnd Bergmann <arnd@arndb.de> wrote:
> The patch 7fb8d215706 "ARM: EXYNOS: Update HSOTG PHY clock setting for EXYNOS4X12"
> in the exynos tree causes a new warning in exynos4_defconfig:
>
> arch/arm/mach-exynos/setup-usb-phy.c: In function 'exynos4210_usb_phy_clkset':
> arch/arm/mach-exynos/setup-usb-phy.c:83:97: error: 'phyclk' may be used uninitialized in this function [-Werror=uninitialized]
>
> Please fix.
>
>         Arnd



-- 
With warm regards,
Sachin
