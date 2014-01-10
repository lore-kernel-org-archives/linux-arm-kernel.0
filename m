From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Fri, 10 Jan 2014 12:49:09 +0900
Subject: [PATCHv9 4/4] ARM: socfpga_defconfig: enable SD/MMC support
In-Reply-To: <1389303079-19808-5-git-send-email-dinguyen@altera.com>
References: <1389303079-19808-1-git-send-email-dinguyen@altera.com>
 <1389303079-19808-5-git-send-email-dinguyen@altera.com>
Message-ID: <52CF6DB5.7080903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 01/10/2014 06:31 AM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Enables the dw_mmc driver for SOCFPGA.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> ---
> v9: none
> v8: none
> v7: none
> v6: none
> v5: Add dw_mmc driver into socfpga_defconfig
> v4: none
> v3: none
> v2: none
> ---
>  arch/arm/configs/socfpga_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> index 4e1ce21..8fff96ba 100644
> --- a/arch/arm/configs/socfpga_defconfig
> +++ b/arch/arm/configs/socfpga_defconfig
> @@ -82,3 +82,5 @@ CONFIG_DEBUG_INFO=y
>  CONFIG_ENABLE_DEFAULT_TRACERS=y
>  CONFIG_DEBUG_USER=y
>  CONFIG_XZ_DEC=y
> +CONFIG_MMC=y
> +CONFIG_MMC_DW=y
> 
