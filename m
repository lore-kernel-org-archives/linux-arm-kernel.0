From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 12 Jul 2017 16:42:39 +0200
Subject: [PATCH] ARM: dts: imx: add CX9020 Embedded PC device tree
In-Reply-To: <20170712090408.12212-1-linux-kernel-dev@beckhoff.com>
References: <20170712090408.12212-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20170712144239.GC2557@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 12, 2017 at 11:04:08AM +0200, linux-kernel-dev at beckhoff.com wrote:
> From: Patrick Br?nn <p.bruenn@beckhoff.com>
> 
> The CX9020 differs from i.MX53 Quick Start Board by:
> - use uart2 instead of uart1
> - DVI-D connector instead of VGA
> - no audio
> - CCAT FPGA connected to emi
> - enable rtc
> 
> Signed-off-by: Patrick Br?nn <p.bruenn@beckhoff.com>
> ---
>  arch/arm/boot/dts/Makefile         |   1 +
>  arch/arm/boot/dts/imx53-cx9020.dts | 377 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 378 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx53-cx9020.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9c5e1d944d1c..ea60698f9783 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -340,6 +340,7 @@ dtb-$(CONFIG_SOC_IMX53) += \
>  	imx53-ard.dtb \
>  	imx53-m53evk.dtb \
>  	imx53-mba53.dtb \
> +	imx53-cx9020.dtb \
>  	imx53-qsb.dtb \
>  	imx53-qsrb.dtb \
>  	imx53-smd.dtb \

Hi Patrick

It appears this list is in alphabetic order...

   Andrew
