From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Tue, 28 Aug 2018 10:20:48 +0200
Subject: [PATCH v2] drm/rockchip: fix coding style and incorrect
 description
In-Reply-To: <1535442295-4007-1-git-send-email-hjc@rock-chips.com>
References: <1535442295-4007-1-git-send-email-hjc@rock-chips.com>
Message-ID: <CAFqH_53aJX=n_kzvf=xjWGTSu2ak8q8wJ3nGM94e_OGLYAKWAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missatge de Sandy Huang <hjc@rock-chips.com> del dia dt., 28 d?ag.
2018 a les 9:45:
>
> Align with other drivers, tab + 2 space key for description.
> and edp/hdmi/dsi can be used on both rk3288 and rk3399.
>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/Kconfig | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 0ccc762..0534dc1 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -23,7 +23,7 @@ config ROCKCHIP_ANALOGIX_DP
>         help
>           This selects support for Rockchip SoC specific extensions
>           for the Analogix Core DP driver. If you want to enable DP
> -         on RK3288 based SoC, you should selet this option.
> +         on RK3288 or RK3399 based SoC, you should select this option.
>
>  config ROCKCHIP_CDN_DP
>          bool "Rockchip cdn DP"
> @@ -39,16 +39,16 @@ config ROCKCHIP_DW_HDMI
>          help
>           This selects support for Rockchip SoC specific extensions
>           for the Synopsys DesignWare HDMI driver. If you want to
> -         enable HDMI on RK3288 based SoC, you should selet this
> -         option.
> +         enable HDMI on RK3288 or RK3399 based SoC, you should select
> +         this option.
>
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
> +         select this option.
>
>  config ROCKCHIP_INNO_HDMI
>         bool "Rockchip specific extensions for Innosilicon HDMI"
> --
> 2.7.4

If it helps...

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

>
>
