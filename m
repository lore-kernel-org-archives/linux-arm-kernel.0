From: rdunlap@infradead.org (Randy Dunlap)
Date: Wed, 30 May 2018 14:17:58 -0700
Subject: [PATCH v7 10/10] drivers: clk: Add ZynqMP clock driver
In-Reply-To: <1527713725-1086-11-git-send-email-jollys@xilinx.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
 <1527713725-1086-11-git-send-email-jollys@xilinx.com>
Message-ID: <c042fd9b-85cb-f0d3-101c-f78f3dc4fc44@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2018 01:55 PM, Jolly Shah wrote:
> From: Jolly Shah <jolly.shah@xilinx.com>


> diff --git a/drivers/clk/zynqmp/Kconfig b/drivers/clk/zynqmp/Kconfig
> new file mode 100644
> index 0000000..fe815f7
> --- /dev/null
> +++ b/drivers/clk/zynqmp/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config COMMON_CLK_ZYNQMP
> +	bool "Support for Xilinx ZynqMP Ultrascale+ clock controllers"
> +	depends on OF
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on ZYNQMP_FIRMWARE
> +	help
> +	  Support for the Zynqmp Ultrascale clock controller.
> +	  It has a dependency on the PMU firmware.
> +	  Say Y if you want to support clock support

	  Say Y if you want to include clock support.


-- 
~Randy
