From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 16 May 2014 10:43:33 +0200
Subject: [PATCH v6 13/17] ARM: shmobile: marzen: Add to shmobile defconfig
In-Reply-To: <20140516000409.GB29432@verge.net.au>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
 <1400153532-23675-14-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXPm_=ejkcnOFOgfnsz9MUc8KpAjkuMcHMKJeaEmVbhQA@mail.gmail.com>
 <20140515225027.GA29432@verge.net.au>
 <20140516000409.GB29432@verge.net.au>
Message-ID: <CAMuHMdWjxK5K4rhJt0VDbsSUX_Gzq8EXCPStN3bb_GUqq8tEog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, May 16, 2014 at 2:04 AM, Simon Horman <horms@verge.net.au> wrote:
> Add marzen to shmobile defconfig now that it supports multiplatform
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> v6.1
> * Also enable SPI_SH_HSPI and USB_RCAR_PHY
>
> v2 - v6
> * No Change
>
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index b76fb9b..114e88e 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig

> +CONFIG_USB_RCAR_PHY=y
> +CONFIG_USB_RCAR_GEN2_PHY=y

While I don't dispute the need for CONFIG_USB_RCAR_GEN2_PHY in
shmobile_defconfig, this is not needed for Marzen, right?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
