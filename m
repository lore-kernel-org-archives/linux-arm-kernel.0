From: koba@kmckk.co.jp (Tetsuyuki Kobayashi)
Date: Wed, 07 Nov 2012 19:54:58 +0900
Subject: [PATCH 06/15] ARM: shmobile: Add DT table of INTC for sh73a0
In-Reply-To: <1352278244-26702-7-git-send-email-horms@verge.net.au>
References: <1352278244-26702-1-git-send-email-horms@verge.net.au>
 <1352278244-26702-7-git-send-email-horms@verge.net.au>
Message-ID: <509A3E02.3050507@kmckk.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Iwamatsu-san, Simon-san

(2012/11/07 17:50), Simon Horman wrote:
> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>   arch/arm/boot/dts/sh73a0.dtsi |  810 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 810 insertions(+)
>   create mode 100644 arch/arm/boot/dts/sh73a0.dtsi
> 
> diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
> new file mode 100644
> index 0000000..b0c55e1
> --- /dev/null
> +++ b/arch/arm/boot/dts/sh73a0.dtsi
> @@ -0,0 +1,810 @@
> +/*
> + * Device Tree Source for the SH73A0
> + *
> + * Copyright (C) 2012 Renesas Solutions Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	compatible = "renesas,sh73a0";
> +
> +	cpus {
> +		cpu at 0 {
> +			compatible = "arm,cortex-a8";
> +		};
> +	};

SH73A0 is dual core cortex-a9.
