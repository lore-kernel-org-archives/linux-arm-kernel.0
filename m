From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Oct 2015 13:43:53 +0100
Subject: [PATCH V3 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
In-Reply-To: <1444822498-16477-5-git-send-email-B48286@freescale.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
 <1444822498-16477-5-git-send-email-B48286@freescale.com>
Message-ID: <20151014124353.GC2150@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <0 106 0x4>,
> +			     <0 107 0x4>,
> +			     <0 95 0x4>,
> +			     <0 97 0x4>;
> +	};

You should have interrupt-affinity here. See
Documentation/devicetree/bindings/arm/pmu.txt

Otherwise this looks ok.

Thanks,
Mark.
