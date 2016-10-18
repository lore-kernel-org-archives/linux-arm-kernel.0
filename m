From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 18 Oct 2016 09:53:02 +0200
Subject: [PATCH 05/19] ARM: multi_v7_defconfig: Remove miphy365 phy.
In-Reply-To: <1473859677-9231-6-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-6-git-send-email-peter.griffin@linaro.org>
Message-ID: <ad4daf4b-5d2e-e99c-0b01-cf48a747394d@st.com>
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
> index 2c8665c..949ab7f 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -854,7 +854,6 @@ CONFIG_PHY_ROCKCHIP_DP=m
>  CONFIG_PHY_ROCKCHIP_USB=m
>  CONFIG_PHY_QCOM_APQ8064_SATA=m
>  CONFIG_PHY_MIPHY28LP=y
> -CONFIG_PHY_MIPHY365X=y
>  CONFIG_PHY_RCAR_GEN2=m
>  CONFIG_PHY_STIH41X_USB=y
>  CONFIG_PHY_STIH407_USB=y
> 
