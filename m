From: rdunlap@infradead.org (Randy Dunlap)
Date: Thu, 30 Aug 2018 08:36:52 -0700
Subject: [PATCH 2/3] iio: adc: Add Xilinx AMS driver
In-Reply-To: <1535624539-7839-3-git-send-email-manish.narani@xilinx.com>
References: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
 <1535624539-7839-3-git-send-email-manish.narani@xilinx.com>
Message-ID: <378c10f8-9760-b36a-431d-4ce4339d7345@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2018 03:22 AM, Manish Narani wrote:
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 4a75492..405ea00 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -941,4 +941,14 @@ config XILINX_XADC
>  	  The driver can also be build as a module. If so, the module will be called
>  	  xilinx-xadc.
>  
> +config XILINX_AMS
> +	tristate "Xilinx AMS driver"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Say yes here to have support for the Xilinx AMS.
> +
> +	  The driver can also be build as a module. If so, the module will be called

	                         built

> +	  xilinx-ams.
> +
>  endmenu


-- 
~Randy
