From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 20 Sep 2017 14:30:46 +0200
Subject: [PATCH 1/9] arm64: defconfig: enable the Marvell 10G PHY as a
 module
In-Reply-To: <20170918075814.27405-2-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Mon, 18 Sep 2017 09:58:06 +0200")
References: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
 <20170918075814.27405-2-antoine.tenart@free-electrons.com>
Message-ID: <87377hr1qh.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On lun., sept. 18 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> The Marvell 10G PHY is present on mvebu platforms. Enable it as a module
> so that the network works on these platforms.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on mvebu/arm64

Thanks,

Gregory

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 34480e9af2e7..4c9d4f6692dc 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -204,6 +204,7 @@ CONFIG_STMMAC_ETH=m
>  CONFIG_MDIO_BUS_MUX_MMIOREG=y
>  CONFIG_AT803X_PHY=m
>  CONFIG_MARVELL_PHY=m
> +CONFIG_MARVELL_10G_PHY=m
>  CONFIG_MESON_GXL_PHY=m
>  CONFIG_MICREL_PHY=y
>  CONFIG_REALTEK_PHY=m
> -- 
> 2.13.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
