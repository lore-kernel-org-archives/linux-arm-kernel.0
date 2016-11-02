From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 2 Nov 2016 16:25:07 -0500
Subject: [PATCH] ARM: socfpga: updates for socfpga_defconfig
In-Reply-To: <1478044484-2331-1-git-send-email-atull@opensource.altera.com>
References: <1478044484-2331-1-git-send-email-atull@opensource.altera.com>
Message-ID: <182cb9e2-df52-b655-0d69-b623985b4137@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/01/2016 06:54 PM, Alan Tull wrote:
> This patch enables the following in the
> socfpga_defconfig:
> 
> +CONFIG_OF_OVERLAY=y
>   Enable support for Device Tree Overlays
> 
> +CONFIG_FPGA_REGION=y
>   Enable device tree overlay support for FPGA
>   programming
> 
> +CONFIG_FPGA_MGR_SOCFPGA_A10=y
>   Enable partial reconfiguration for Altera
>   Arria 10 FPGA
> 
> +CONFIG_FPGA_BRIDGE=y
>   Enable the FPGA Bridges framework
> 
> +CONFIG_SOCFPGA_FPGA_BRIDGE=y
>   Enable support for SoCFPGA hardware
>   bridges
> 
> +CONFIG_ALTERA_FREEZE_BRIDGE=y
>   Enable support for the Altera Soft IP
>   Freeze bridges
> 
> Signed-off-by: Alan Tull <atull@opensource.altera.com>
> ---
>  arch/arm/configs/socfpga_defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> index f5b9bc5..18d3ec1 100644
> --- a/arch/arm/configs/socfpga_defconfig
> +++ b/arch/arm/configs/socfpga_defconfig
> @@ -54,6 +54,7 @@ CONFIG_DEVTMPFS_MOUNT=y

Applied!

Thanks,
Dinh
