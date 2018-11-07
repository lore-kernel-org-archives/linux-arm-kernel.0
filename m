From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Wed, 7 Nov 2018 21:51:58 +0100
Subject: [PATCH 5/9] arm64: defconfig: Replace PINCTRL_MT7622 with
 PINCTRL_MTK_MOORE
In-Reply-To: <5889bd19-3717-9592-3473-bf11338007da@free.fr>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <5889bd19-3717-9592-3473-bf11338007da@free.fr>
Message-ID: <af87b13d-4551-7c82-6183-f9c31d93c653@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Add interested parties ]

On 07/11/2018 21:16, Marc Gonzalez wrote:

> Commit e78d57b2f87c ("pinctrl: mediatek: add pinctrl-moore that implements
> the generic pinctrl dt-bindings")
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6fe418d72337..725b9471b21c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -369,7 +369,7 @@ CONFIG_PINCTRL_MSM8994=y
>  CONFIG_PINCTRL_MSM8996=y
>  CONFIG_PINCTRL_QDF2XXX=y
>  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
> -CONFIG_PINCTRL_MT7622=y
> +CONFIG_PINCTRL_MTK_MOORE=y
>  CONFIG_GPIO_DWAPB=y
>  CONFIG_GPIO_MB86S7X=y
>  CONFIG_GPIO_PL061=y
> 
