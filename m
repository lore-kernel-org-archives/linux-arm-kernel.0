From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Mon, 27 Aug 2018 09:02:04 +0200
Subject: [PATCH] drm/rockchip: fix coding style and incorrect description
In-Reply-To: <1535351378-128643-1-git-send-email-hjc@rock-chips.com>
References: <1535351378-128643-1-git-send-email-hjc@rock-chips.com>
Message-ID: <CAFqH_514pyvKTNHYM=wDab6yAPB+cDCNy8shHPpOP5aeLkyafg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sandy,

Just noticed a typo that I think will be good fix also
Missatge de Sandy Huang <hjc@rock-chips.com> del dia dl., 27 d?ag.
2018 a les 8:31:
>
> Align with other drivers, tab + 2 space key for description.
> and this option should be enabled on both rk3288 and rk3399.
>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 0ccc762..601234b 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -45,10 +45,10 @@ config ROCKCHIP_DW_HDMI
>  config ROCKCHIP_DW_MIPI_DSI
>         bool "Rockchip specific extensions for Synopsys DW MIPI DSI"
>         help
> -        This selects support for Rockchip SoC specific extensions
> -        for the Synopsys DesignWare HDMI driver. If you want to
> -        enable MIPI DSI on RK3288 based SoC, you should selet this
> -        option.
> +         This selects support for Rockchip SoC specific extensions
> +         for the Synopsys DesignWare HDMI driver. If you want to
> +         enable MIPI DSI on RK3288 or RK3399 based SoC, you should
> +         selet this option.

s/selet/select/

Cheers,
 Enric

>
>  config ROCKCHIP_INNO_HDMI
>         bool "Rockchip specific extensions for Innosilicon HDMI"
> --
> 2.7.4
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
