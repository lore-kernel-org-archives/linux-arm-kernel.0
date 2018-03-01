From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 02 Mar 2018 08:42:40 +0900
Subject: [PATCH] arm64: defconfig: Enable typec-phy and
 extcon-usbc-cros-ec for rk3399
In-Reply-To: <20180228140251.22232-1-enric.balletbo@collabora.com>
References: <CGME20180228140304epcas3p377c02db2d4f9f5d2549f433e08b51ea4@epcas3p3.samsung.com>
 <20180228140251.22232-1-enric.balletbo@collabora.com>
Message-ID: <5A988FF0.3080302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018? 02? 28? 23:02, Enric Balletbo i Serra wrote:
> Enables typec phyter and extcon driver for cable detection that is used by
> USB 3.0 controller for Rockchip rk3399 SoCs.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 78b47bc7dc54..d4c25aa55785 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -544,6 +544,7 @@ CONFIG_ARCH_TEGRA_132_SOC=y
>  CONFIG_ARCH_TEGRA_210_SOC=y
>  CONFIG_ARCH_TEGRA_186_SOC=y
>  CONFIG_EXTCON_USB_GPIO=y
> +CONFIG_EXTCON_USBC_CROS_EC=y
>  CONFIG_IIO=y
>  CONFIG_EXYNOS_ADC=y
>  CONFIG_ROCKCHIP_SARADC=m
> @@ -564,6 +565,7 @@ CONFIG_PHY_MVEBU_CP110_COMPHY=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_EMMC=y
>  CONFIG_PHY_ROCKCHIP_PCIE=m
> +CONFIG_PHY_ROCKCHIP_TYPEC=y
>  CONFIG_PHY_XGENE=y
>  CONFIG_PHY_TEGRA_XUSB=y
>  CONFIG_QCOM_L2_PMU=y
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
