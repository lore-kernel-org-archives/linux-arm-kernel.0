From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Aug 2014 11:50:48 +0100
Subject: [PATCH V2 4/4] ARM: dts: i.MX53: Add PMU DT entry
In-Reply-To: <20140805144840.25462.57101.stgit@localhost>
References: <20140805144831.25462.18149.stgit@localhost>
 <20140805144840.25462.57101.stgit@localhost>
Message-ID: <20140806105048.GF25953@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 03:48:40PM +0100, Martin Fuzzey wrote:
> Add device tree node for PMU on i.MX53
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  arch/arm/boot/dts/imx53.dtsi |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 6456a00..ab3afe0 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -101,6 +101,11 @@
>  		interrupt-parent = <&tzic>;
>  		ranges;
>  
> +		pmu {
> +			compatible = "arm,cortex-a8-pmu";
> +			interrupts = <77>;
> +		};

You're missing the new property.

Will
