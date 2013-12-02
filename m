From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Dec 2013 08:09:39 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: enable network for BeagleBone
 Black
In-Reply-To: <1385972129-3638-1-git-send-email-olof@lixom.net>
References: <1385972129-3638-1-git-send-email-olof@lixom.net>
Message-ID: <20131202160938.GH23334@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [131202 00:15]:
> BeagleBone Black uses the TI CPSW ethernet controller, enable it in the
> multi_v7_defconfig for testing coverage purposes.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/configs/multi_v7_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 4a5903e..d30507d 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -69,6 +69,7 @@ CONFIG_KS8851=y
>  CONFIG_SMSC911X=y
>  CONFIG_STMMAC_ETH=y
>  CONFIG_MDIO_SUN4I=y
> +CONFIG_TI_CPSW=y
>  CONFIG_KEYBOARD_SPEAR=y
>  CONFIG_SERIO_AMBAKMI=y
>  CONFIG_SERIAL_8250=y
> -- 
> 1.7.10.4
> 
