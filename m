From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 16:22:53 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable XADC driver
In-Reply-To: <1401984324-6075-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1401984324-6075-1-git-send-email-soren.brinkmann@xilinx.com>
 <1401984324-6075-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <201406131622.54169.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 June 2014, Soren Brinkmann wrote:
> The Xilinx A/D Converter is found in Xilinx devices including Zynq.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index e2d62048e198..2d1039d8c7f1 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -360,6 +360,7 @@ CONFIG_TEGRA_IOMMU_GART=y
>  CONFIG_TEGRA_IOMMU_SMMU=y
>  CONFIG_MEMORY=y
>  CONFIG_IIO=y
> +CONFIG_XILINX_XADC=y
>  CONFIG_AK8975=y
>  CONFIG_PWM=y
>  CONFIG_PWM_TEGRA=y
> -- 

Applied both to fixes branch.

	Arnd
