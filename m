From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Feb 2017 17:07:43 +0000
Subject: [PATCH 08/11] ARM: dts: Prepare Actions Semi S500 and LeMaker
 Guitar
In-Reply-To: <20170215165528.10052-9-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
 <20170215165528.10052-9-afaerber@suse.de>
Message-ID: <20170215170742.GH31733@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 05:55:25PM +0100, Andreas F?rber wrote:
> +	arm-pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +		             <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +		             <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +		             <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +        };

Please add an interrupt-affinity property, as described in
Documentation/devicetree/bindings/arm/pmu.txt

Thanks,
Mark.
