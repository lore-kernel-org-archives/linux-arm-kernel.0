From: nm@ti.com (Nishanth Menon)
Date: Wed, 5 Jun 2013 08:57:39 -0500
Subject: [PATCH 2/4] ARM: dts: omap5-uevm: Add USB Host support
In-Reply-To: <1370414770-1485-3-git-send-email-r.sricharan@ti.com>
References: <1370414770-1485-1-git-send-email-r.sricharan@ti.com>
 <1370414770-1485-3-git-send-email-r.sricharan@ti.com>
Message-ID: <20130605135739.GA11193@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:16-20130605, Sricharan R wrote:
> From: Roger Quadros <rogerq@ti.com>
[...]
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 843a001..cf862df 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
<snip>
> +	/* hsusb2_phy is clocked by FREF_CLK1 i.e. auxclk1 */
> +	clock_alias {
> +		clock-name = "auxclk1_ck";
> +		clock-alias = "main_clk";
is'nt this better to use with clock node?
> +		device = <&hsusb2_phy>;
> +		clock-frequency = <19200000>; /* 19.2 MHz */
> +	};
>  };
<snip>
-- 
Regards,
Nishanth Menon
