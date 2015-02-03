From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 03 Feb 2015 23:23:03 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: update Berlin config
In-Reply-To: <1422975184-25985-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1422975184-25985-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <54D14A47.1030107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.02.2015 15:53, Antoine Tenart wrote:
> Marvell Berlin SoCs are supported in the multi_v7_defconfig. However
> some options were missing to support some features.
>
> This patch adds the missing features: pxa168 Ethernet, Berlin USB PHY
> and Berlin SATA PHY.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Thanks!

> ---
>   arch/arm/configs/multi_v7_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index bc393b7e5ece..8e803d42142d 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -161,6 +161,7 @@ CONFIG_NET_CALXEDA_XGMAC=y
>   CONFIG_IGB=y
>   CONFIG_MV643XX_ETH=y
>   CONFIG_MVNETA=y
> +CONFIG_PXA168_ETH=y
>   CONFIG_KS8851=y
>   CONFIG_R8169=y
>   CONFIG_SMSC911X=y
> @@ -452,6 +453,8 @@ CONFIG_PWM=y
>   CONFIG_PWM_TEGRA=y
>   CONFIG_PWM_VT8500=y
>   CONFIG_PHY_HIX5HD2_SATA=y
> +CONFIG_PHY_BERLIN_USB=y
> +CONFIG_PHY_BERLIN_SATA=y
>   CONFIG_OMAP_USB2=y
>   CONFIG_TI_PIPE3=y
>   CONFIG_PHY_MIPHY365X=y
>
