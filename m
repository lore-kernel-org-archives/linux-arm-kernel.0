From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 18 Nov 2015 16:05:47 +0000
Subject: [PATCH v9 1/2] arm-soc: Import initial tango4 device tree
In-Reply-To: <564C94FD.60607@sigmadesigns.com> (Marc Gonzalez's message of
 "Wed, 18 Nov 2015 16:10:53 +0100")
References: <564C94A5.4060301@sigmadesigns.com>
 <564C94FD.60607@sigmadesigns.com>
Message-ID: <yw1xr3jnfg2s.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> +		clkgen: clkgen at 10000 {
> +			compatible = "sigma,tango4-clkgen";
> +			reg = <0x10000 0x40>;
> +			clocks = <&xtal>;
> +			clock-output-names = "cpuclk", "sysclk";
> +			#clock-cells = <1>;
> +		};

Would you please consider using my clock driver that matches the actual
hardware, supports all the clock outputs required for USB, SATA, etc,
and works on tango3 as well?

-- 
M?ns Rullg?rd
mans at mansr.com
