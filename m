From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 4 Jul 2018 13:47:54 +0200
Subject: [PATCH 3/5] ARM: shmobile: defconfig: Enable support for RZN1D-DB
In-Reply-To: <20180704114333.27584-4-geert+renesas@glider.be>
References: <20180704114333.27584-1-geert+renesas@glider.be>
 <20180704114333.27584-4-geert+renesas@glider.be>
Message-ID: <CAMuHMdXORDTQNXswW1ePx=X_w3ckcfUSKDfGpMAoyBs46-goVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC Michel

On Wed, Jul 4, 2018 at 1:43 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Enable support for the Renesas RZN1D-DB Board:
>   - RZ/N1D (R9A06G032) base SoC support,
>   - Synopsys DesignWare 8250 serial port support.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> ---
>  arch/arm/configs/shmobile_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index a08d0bcdca750d28..7a5a970420b6353a 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -22,6 +22,7 @@ CONFIG_ARCH_R8A7791=y
>  CONFIG_ARCH_R8A7792=y
>  CONFIG_ARCH_R8A7793=y
>  CONFIG_ARCH_R8A7794=y
> +CONFIG_ARCH_R9A06G032=y
>  CONFIG_ARCH_SH73A0=y
>  CONFIG_PL310_ERRATA_588369=y
>  CONFIG_ARM_ERRATA_754322=y
> @@ -88,6 +89,7 @@ CONFIG_INPUT_ADXL34X=y
>  # CONFIG_LEGACY_PTYS is not set
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_8250_EM=y
>  CONFIG_SERIAL_SH_SCI=y
>  CONFIG_I2C_CHARDEV=y

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
