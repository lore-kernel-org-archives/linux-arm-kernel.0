From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 17:22:15 +0100
Subject: [PATCH v2 9/9] ARM: multi_v7_defconfig: Enable STi FDMA driver
In-Reply-To: <1441980871-24475-10-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-10-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150911162215.GB18779@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Peter Griffin wrote:

> This DMA controller is found on all STi chipsets.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 5fd8df6..ce3c8c1 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -587,6 +587,7 @@ CONFIG_IMX_DMA=y
>  CONFIG_MXS_DMA=y
>  CONFIG_DMA_OMAP=y
>  CONFIG_XILINX_VDMA=y
> +CONFIG_ST_FDMA=y
>  CONFIG_STAGING=y
>  CONFIG_SENSORS_ISL29018=y
>  CONFIG_SENSORS_ISL29028=y

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
