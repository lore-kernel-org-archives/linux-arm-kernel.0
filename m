From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 May 2012 10:02:50 +0200
Subject: [PATCH] ARM: PRIMA2: select PINCTRL and PINCTRL_SIRF in Kconfig
In-Reply-To: <1337049346-32726-1-git-send-email-Barry.Song@csr.com>
References: <1337049346-32726-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdZh1d2f3GYATmwR86ZrhxhBpNKUzzF1wLJwbKvU3rkVew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 4:35 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
> ?arch/arm/Kconfig | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 36586db..8dfbecd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -407,6 +407,8 @@ config ARCH_PRIMA2
> ? ? ? ?select CLKDEV_LOOKUP
> ? ? ? ?select GENERIC_IRQ_CHIP
> ? ? ? ?select MIGHT_HAVE_CACHE_L2X0
> + ? ? ? select PINCTRL
> + ? ? ? select PINCTRL_SIRF
> ? ? ? ?select USE_OF
> ? ? ? ?select ZONE_DMA
> ? ? ? ?help

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
