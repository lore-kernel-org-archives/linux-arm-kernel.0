From: horms@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 11:12:53 +0200
Subject: [PATCH 0/7] ARM: dts: renesas: Use R-Car SDHI Gen[12] fallback
 compat strings
In-Reply-To: <20171018072728.14681-1-horms+renesas@verge.net.au>
References: <20171018072728.14681-1-horms+renesas@verge.net.au>
Message-ID: <20171020091253.tvvd3thgrg27svxb@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 09:27:21AM +0200, Simon Horman wrote:
> Use recently posted R-Car Gen 1 and 2 Ether fallback compat strings
> in the DT of Renesas ARM based SoCs.
> 
> Based on renesas-devel-20171018-v4.14-rc5
> 
> Has a binding documentation but no run-time dependency on
> "[PATCH net-next 0/3] net: sh_eth: add R-Car Gen[12] fallback compatibility
> strings"

The above dependency has been accepted into net-next.

I have applied this series for v4.16 with Geert's review tags.

> 
> Simon Horman (7):
>   ARM: dts: r8a7743: Use R-Car Gen2 Ether fallback compat string
>   ARM: dts: r8a7745: Use R-Car Gen2 Ether fallback compat string

The above used spaces instead of tabs for indentation,
I fixed this when applying.

>   ARM: dts: r8a7778: Use R-Car Gen1 Ether fallback compat string
>   ARM: dts: r8a7790: Use R-Car Gen2 Ether fallback compat string
>   ARM: dts: r8a7791: Use R-Car Gen2 Ether fallback compat string
>   ARM: dts: r8a7793: Use R-Car Gen2 Ether fallback compat string
>   ARM: dts: r8a7794: Use R-Car Gen2 Ether fallback compat string
> 
>  arch/arm/boot/dts/r8a7743.dtsi | 3 ++-
>  arch/arm/boot/dts/r8a7745.dtsi | 3 ++-
>  arch/arm/boot/dts/r8a7778.dtsi | 3 ++-
>  arch/arm/boot/dts/r8a7790.dtsi | 3 ++-
>  arch/arm/boot/dts/r8a7791.dtsi | 3 ++-
>  arch/arm/boot/dts/r8a7793.dtsi | 3 ++-
>  arch/arm/boot/dts/r8a7794.dtsi | 3 ++-
>  7 files changed, 14 insertions(+), 7 deletions(-)
> 
> -- 
> 2.11.0
> 
