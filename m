From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 18 Oct 2016 09:53:19 +0200
Subject: [PATCH 06/19] ARM: multi_v7_defconfig: Remove stih41x phy Kconfig
 symbol.
In-Reply-To: <1473859677-9231-7-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-7-git-send-email-peter.griffin@linaro.org>
Message-ID: <ad2367f8-7c92-201a-59ec-1f0fc661d818@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 09/14/2016 03:27 PM, Peter Griffin wrote:
> This IP is only found on STiH415/6 silicon and support
> for these SoCs is being removed from the kernel.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: <kishon@ti.com>

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Applied on sti-defconfig-for-4.10 branch

Thanks 

> ---
>  arch/arm/configs/multi_v7_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 949ab7f..b26a541 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -855,7 +855,6 @@ CONFIG_PHY_ROCKCHIP_USB=m
>  CONFIG_PHY_QCOM_APQ8064_SATA=m
>  CONFIG_PHY_MIPHY28LP=y
>  CONFIG_PHY_RCAR_GEN2=m
> -CONFIG_PHY_STIH41X_USB=y
>  CONFIG_PHY_STIH407_USB=y
>  CONFIG_PHY_SUN4I_USB=y
>  CONFIG_PHY_SUN9I_USB=y
> 
