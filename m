From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 10 Jan 2017 15:05:49 +0530
Subject: [PATCH v2 1/6] ARM: dts: davinci: da850: VPIF: add node and muxing
In-Reply-To: <20170109205531.3435-2-khilman@baylibre.com>
References: <20170109205531.3435-1-khilman@baylibre.com>
 <20170109205531.3435-2-khilman@baylibre.com>
Message-ID: <3f8ce316-6d14-4105-5f33-df32d8730128@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 January 2017 02:25 AM, Kevin Hilman wrote:
> Add VPIF node an pins to da850 SoC.  VPIF has two input channels which

s/an/and

> can be described using the standard DT ports and enpoints.

s/enpoints/endpoints

> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

> @@ -465,6 +488,7 @@
>  			status = "disabled";
>  		};
>  	};
> +

This seems like a stray newline addition. I dropped it while applying to
v4.11/dt

Thanks,
Sekhar

>  	aemif: aemif at 68000000 {
>  		compatible = "ti,da850-aemif";
>  		#address-cells = <2>;
> 
