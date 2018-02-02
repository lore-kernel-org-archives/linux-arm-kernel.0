From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 2 Feb 2018 10:58:13 +0100
Subject: [PATCH topic/renesas_defconfig] arm64: renesas_defconfig: enable
 R8A77970 SoC
In-Reply-To: <20180202093609.19306-1-horms+renesas@verge.net.au>
References: <20180202093609.19306-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWJM_OB7tRR4LjEOaigKNkL_ox7-KDUUTbnm5GgG6k0dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 2, 2018 at 10:36 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Enable the Renesas R-Car V3H (R8A77970) SoC in the ARM64 renesas_defconfig.

R8A77980...

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm64/configs/renesas_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
>  Based on renesas-devel-20180202-v4.15
>
>  Not for upstream merge
>
> diff --git a/arch/arm64/configs/renesas_defconfig b/arch/arm64/configs/renesas_defconfig
> index 3087bba06d3c..386211464efa 100644
> --- a/arch/arm64/configs/renesas_defconfig
> +++ b/arch/arm64/configs/renesas_defconfig
> @@ -34,6 +34,7 @@ CONFIG_ARCH_RENESAS=y
>  CONFIG_ARCH_R8A7795=y
>  CONFIG_ARCH_R8A7796=y
>  CONFIG_ARCH_R8A77970=y
> +CONFIG_ARCH_R8A77980=y
>  CONFIG_ARCH_R8A77995=y
>  CONFIG_PCI=y
>  CONFIG_PCIEPORTBUS=y

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
