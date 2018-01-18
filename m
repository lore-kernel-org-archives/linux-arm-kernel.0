From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Fri, 19 Jan 2018 00:04:22 +0100
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable AC97 codec support
In-Reply-To: <1516279527-6516-1-git-send-email-fabio.estevam@nxp.com>
References: <1516279527-6516-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <bbea2d1a-32a8-2b03-5bd6-fd36b0d68d37@maciej.szmigiero.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.01.2018 13:45, Fabio Estevam wrote:
> imx6qdl udoo board has an AC97 codec. 
> 
> Add support for it by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 4cb9829..80ef9ed 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -285,6 +285,7 @@ CONFIG_SND_SOC_IMX_SGTL5000=y
>  CONFIG_SND_SOC_IMX_SPDIF=y
>  CONFIG_SND_SOC_IMX_MC13783=y
>  CONFIG_SND_SOC_FSL_ASOC_CARD=y
> +CONFIG_SND_SOC_AC97_CODEC=y
>  CONFIG_SND_SOC_CS42XX8_I2C=y
>  CONFIG_SND_SOC_TLV320AIC3X=y
>  CONFIG_SND_SOC_WM8960=y
> 

Acked-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Maciej
