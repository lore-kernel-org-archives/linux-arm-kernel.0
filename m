From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 5 Jun 2014 13:25:07 +0100
Subject: [STLinux Kernel] [PATCH 1/6] thermal: sti: Supply Device Tree
 documentation
In-Reply-To: <20140605120147.GA7446@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1401442715-6350-1-git-send-email-lee.jones@linaro.org>
 <1401442715-6350-2-git-send-email-lee.jones@linaro.org>
 <20140605120147.GA7446@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20140605122507.GA24240@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 05 Jun 2014, Peter Griffin wrote:

> Hi Lee,
> 
> > +Example:
> > +
> > +	temp1 at fdfe8000 {
> > +		compatible	= "st,stih416-mpe-thermal";
> > +		reg		= <0xfdfe8000 0x10>;
> > +		clock-names	= "thermal";
> > +		clocks		= <&CLK_M_MPETHSENS>;
> > +		interrupts	= <GIC_SPI 23 IRQ_TYPE_NONE>;
> > +	};
> 
> With the renaming of the STI device tree from upper to lower
> case. The clock name in this example also needs updating.

You're right.  Will rebase and fix.

> Once fixed: -
>  Acked-by: Peter Griffin <peter.griffin@linaro.org>
> 
> Regards,
> 
> Peter

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
