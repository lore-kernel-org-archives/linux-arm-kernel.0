From: rdunlap@infradead.org (Randy Dunlap)
Date: Thu, 14 Jun 2018 13:40:59 -0700
Subject: [PATCH v8 02/10] firmware: xilinx: Add Zynqmp firmware driver
In-Reply-To: <1529000862-11510-3-git-send-email-jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
 <1529000862-11510-3-git-send-email-jollys@xilinx.com>
Message-ID: <7cd908ac-a0cc-3fd0-702f-d36a4e325a68@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2018 11:27 AM, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 

Hi,

> diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
> new file mode 100644
> index 0000000..cce4e4f
> --- /dev/null
> +++ b/drivers/firmware/xilinx/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Kconfig for Xilinx firmwares
> +
> +menu "Zynq MPSoC Firmware Drivers"
> +	depends on ARCH_ZYNQMP
> +
> +config ZYNQMP_FIRMWARE
> +	bool "Enable Xilinx Zynq MPSoC firmware interface"
> +	help
> +	  Firmware interface driver is used by different to

used by different <what>?  Missing something there.

> +	  communicate with the firmware for various platform
> +	  management services.
> +	  Say yes to enable ZynqMP firmware interface driver.
> +	  In doubt, say N

	  If in doubt, say N.

> +
> +endmenu


-- 
~Randy
