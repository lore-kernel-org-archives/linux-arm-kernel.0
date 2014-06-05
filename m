From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 5 Jun 2014 13:01:47 +0100
Subject: [STLinux Kernel] [PATCH 1/6] thermal: sti: Supply Device Tree
 documentation
In-Reply-To: <1401442715-6350-2-git-send-email-lee.jones@linaro.org>
References: <1401442715-6350-1-git-send-email-lee.jones@linaro.org>
 <1401442715-6350-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20140605120147.GA7446@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

> +Example:
> +
> +	temp1 at fdfe8000 {
> +		compatible	= "st,stih416-mpe-thermal";
> +		reg		= <0xfdfe8000 0x10>;
> +		clock-names	= "thermal";
> +		clocks		= <&CLK_M_MPETHSENS>;
> +		interrupts	= <GIC_SPI 23 IRQ_TYPE_NONE>;
> +	};

With the renaming of the STI device tree from upper to lower
case. The clock name in this example also needs updating.

Once fixed: -
 Acked-by: Peter Griffin <peter.griffin@linaro.org>

Regards,

Peter
