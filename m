From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jan 2014 20:28:02 +0800
Subject: [PATCHv4] ARM: dts: Add support for the cpuimx53 board from
 Eukrea and its baseboard.
In-Reply-To: <1389609113-20021-1-git-send-email-denis@eukrea.com>
References: <1389609113-20021-1-git-send-email-denis@eukrea.com>
Message-ID: <20140113122800.GT23525@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 11:31:53AM +0100, Denis Carikli wrote:
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX53_UART1_PINGRP2
> +				MX53_UART1_PINGRP3

It's not your fault, but the pingrp naming is bad.  We should probably
name it in the same way that imx35-pingrp.h does, i.e.
MX53_UART1_RTSCTS_PINGRP1.

Shawn

> +			>;
> +		};
