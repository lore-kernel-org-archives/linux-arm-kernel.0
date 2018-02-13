From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 12 Feb 2018 17:13:02 -0800
Subject: [PATCH] arm64: defconfig: Enable the APCS IPC driver on Qualcomm
 platforms
In-Reply-To: <6ab84c75aadc152fdd7c63282ee6690096b8b704.1518415510.git.amit.kucheria@linaro.org>
References: <6ab84c75aadc152fdd7c63282ee6690096b8b704.1518415510.git.amit.kucheria@linaro.org>
Message-ID: <20180213011302.GZ7250@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 12 Feb 03:03 PST 2018, Amit Kucheria wrote:

> The APCS block is present on several Qualcomm SoCs e.g. 8916, 8996.  On the
> 8916 it is needed to enable the clock controller that in turn enables
> cpufreq on the platform while on the 8996 it is needed for communication
> with RPM.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 634b373..96a8ed8 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -525,6 +525,7 @@ CONFIG_ARM_MHU=y
>  CONFIG_PLATFORM_MHU=y
>  CONFIG_BCM2835_MBOX=y
>  CONFIG_HI6220_MBOX=y
> +CONFIG_QCOM_APCS_IPC=y
>  CONFIG_ROCKCHIP_IOMMU=y
>  CONFIG_ARM_SMMU=y
>  CONFIG_ARM_SMMU_V3=y
> -- 
> 2.7.4
> 
