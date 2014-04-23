From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 18:00:24 +0200
Subject: [PATCH 4/5] ARM: sunxi: Remove reset code from the platform
In-Reply-To: <1398265476-29373-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398265476-29373-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <10836281.Wx7YzfuubV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 April 2014 17:04:35 Maxime Ripard wrote:
> Now that reset is handled either by the watchdog driver for the sun4i, sun5i
> and sun7i, and by a driver of its own for sun6i, we can remove it from the
> platform code.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-sunxi/sunxi.c | 98 ---------------------------------------------
>  1 file changed, 98 deletions(-)
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
