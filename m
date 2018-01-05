From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 5 Jan 2018 13:40:46 +0100
Subject: [PATCH 1/7] arm64: dts: marvell: use SPDX-License-Identifier
 for Armada SoCs
In-Reply-To: <20180105115329.1233-2-gregory.clement@free-electrons.com>
References: <20180105115329.1233-1-gregory.clement@free-electrons.com>
 <20180105115329.1233-2-gregory.clement@free-electrons.com>
Message-ID: <20180105134046.12915b36@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri,  5 Jan 2018 12:53:23 +0100, Gregory CLEMENT wrote:
> Follow the recent trend for the license description, and also fix the
> wrongly stated X11 to MIT.
> 
> As already pointed on the DT ML, the X11 license text [1] is explicitly
> for the X Consortium and has a couple of extra clauses. The MIT
> license text [2] is actually what the current DT files claim.
> 
> [1] https://spdx.org/licenses/X11.html
> [2] https://spdx.org/licenses/MIT.html
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-371x.dtsi       | 38 +-------------------
>  arch/arm64/boot/dts/marvell/armada-372x.dtsi       | 38 +-------------------
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 38 +-------------------
>  arch/arm64/boot/dts/marvell/armada-7020.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-7040.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-70x0.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-8020.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-8040.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-8080.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-80x0.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 41 +---------------------
>  .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi  | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-common.dtsi     |  2 +-
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  6 ++--
>  17 files changed, 18 insertions(+), 596 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-371x.dtsi b/arch/arm64/boot/dts/marvell/armada-371x.dtsi
> index 11226f7b9ed9..dc1182ec9fa1 100644
> --- a/arch/arm64/boot/dts/marvell/armada-371x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-371x.dtsi
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

The previous license was GPL-2.0+ or X11, not GPL-2.0+ or MIT. Any
reason to change from X11 to MIT ?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
