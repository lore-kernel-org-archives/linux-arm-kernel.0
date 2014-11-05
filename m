From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Wed, 05 Nov 2014 06:12:21 +0100
Subject: [PATCH 5/7] pinctrl: Add driver for Zynq
In-Reply-To: <1415041531-15520-6-git-send-email-soren.brinkmann@xilinx.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-6-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <5459B1B5.6030001@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 03.11.2014 um 20:05 schrieb Soren Brinkmann:
> +enum zynq_pinmux_functions {
> +	ZYNQ_PMUX_ethernet0,
> +	ZYNQ_PMUX_ethernet1,
> +	ZYNQ_PMUX_mdio0,
> +	ZYNQ_PMUX_mdio1,
> +	ZYNQ_PMUX_qspi0,
> +	ZYNQ_PMUX_qspi1,
> +	ZYNQ_PMUX_qspi_fbclk,
> +	ZYNQ_PMUX_qspi_cs1,

Are usb0 and usb1 intentionally missing in this patch for lack of
upstream USB driver? If so, then please mention what you left out in the
commit message.

> +	ZYNQ_PMUX_spi0,
> +	ZYNQ_PMUX_spi1,
> +	ZYNQ_PMUX_sdio0,
> +	ZYNQ_PMUX_sdio0_pc,
> +	ZYNQ_PMUX_sdio0_cd,
> +	ZYNQ_PMUX_sdio0_wp,
> +	ZYNQ_PMUX_sdio1,
> +	ZYNQ_PMUX_sdio1_pc,
> +	ZYNQ_PMUX_sdio1_cd,
> +	ZYNQ_PMUX_sdio1_wp,
> +	ZYNQ_PMUX_smc0_nor,
> +	ZYNQ_PMUX_smc0_nor_cs1,
> +	ZYNQ_PMUX_smc0_nor_addr25,
> +	ZYNQ_PMUX_smc0_nand,
> +	ZYNQ_PMUX_can0,
> +	ZYNQ_PMUX_can1,
> +	ZYNQ_PMUX_uart0,
> +	ZYNQ_PMUX_uart1,
> +	ZYNQ_PMUX_i2c0,
> +	ZYNQ_PMUX_i2c1,
> +	ZYNQ_PMUX_ttc0,
> +	ZYNQ_PMUX_ttc1,
> +	ZYNQ_PMUX_swdt0,
> +	ZYNQ_PMUX_gpio0,
> +	ZYNQ_PMUX_MAX_FUNC
> +};

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/9499a213/attachment.sig>
