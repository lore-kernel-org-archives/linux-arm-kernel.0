From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 31 Mar 2011 15:58:56 +0200
Subject: [PATCH] ARM: imx/mx25: add NAND chip select pins to iomux
In-Reply-To: <cae1d71db47204ee2654eca7391cb656ed53566b.1300095569.git.baruch@tkos.co.il>
References: <cae1d71db47204ee2654eca7391cb656ed53566b.1300095569.git.baruch@tkos.co.il>
Message-ID: <20110331135856.GI15994@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Ping?

baruch

On Mon, Mar 14, 2011 at 11:40:21AM +0200, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx25.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
> index d7f52c9..2e5244d 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
> @@ -89,13 +89,16 @@
>  #define MX25_PAD_CS0__GPIO_4_2		IOMUX_PAD(0x000, 0x04c, 0x05, 0, 0, NO_PAD_CTRL)
>  
>  #define MX25_PAD_CS1__CS1		IOMUX_PAD(0x000, 0x050, 0x00, 0, 0, NO_PAD_CTRL)
> +#define MX25_PAD_CS1__NF_CE3		IOMUX_PAD(0x000, 0x050, 0x01, 0, 0, NO_PAD_CTRL)
>  #define MX25_PAD_CS1__GPIO_4_3		IOMUX_PAD(0x000, 0x050, 0x05, 0, 0, NO_PAD_CTRL)
>  
>  #define MX25_PAD_CS4__CS4		IOMUX_PAD(0x264, 0x054, 0x10, 0, 0, NO_PAD_CTRL)
> +#define MX25_PAD_CS4__NF_CE1		IOMUX_PAD(0x264, 0x054, 0x01, 0, 0, NO_PAD_CTRL)
>  #define MX25_PAD_CS4__UART5_CTS		IOMUX_PAD(0x264, 0x054, 0x13, 0, 0, NO_PAD_CTRL)
>  #define MX25_PAD_CS4__GPIO_3_20		IOMUX_PAD(0x264, 0x054, 0x15, 0, 0, NO_PAD_CTRL)
>  
>  #define MX25_PAD_CS5__CS5		IOMUX_PAD(0x268, 0x058, 0x10, 0, 0, NO_PAD_CTRL)
> +#define MX25_PAD_CS5__NF_CE2		IOMUX_PAD(0x268, 0x058, 0x01, 0, 0, NO_PAD_CTRL)
>  #define MX25_PAD_CS5__UART5_RTS		IOMUX_PAD(0x268, 0x058, 0x13, 0x574, 0, NO_PAD_CTRL)
>  #define MX25_PAD_CS5__GPIO_3_21		IOMUX_PAD(0x268, 0x058, 0x15, 0, 0, NO_PAD_CTRL)

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
