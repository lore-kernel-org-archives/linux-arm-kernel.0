From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 12 Jun 2012 00:43:30 +0200
Subject: [PATCH] ARM: omap: Fix dts files w/ status property: "disable"
 -> "disabled"
In-Reply-To: <1339441785-14641-1-git-send-email-stigge@antcom.de>
References: <1339441785-14641-1-git-send-email-stigge@antcom.de>
Message-ID: <4FD67492.2040102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/11/2012 9:09 PM, Roland Stigge wrote:
> This patches fixes some status = "disable" strings to "disabled", the correct
> way of disabling nodes in the devicetree.
>
> Just the OMAP part here, the rest goes via other patches and trees.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

> Applies to v3.5-rc2
>
>   arch/arm/boot/dts/omap3-beagle.dts |    4 +--
>   arch/arm/boot/dts/omap4-panda.dts  |    6 ++---
>   arch/arm/boot/dts/omap4-sdp.dts    |    4 +--
>   arch/arm/boot/dts/tegra20.dtsi     |   36 +++++++++++++++++------------------
>   arch/arm/boot/dts/tegra30.dtsi     |   38 ++++++++++++++++++-------------------

Nit: the diffstat does not match that patch, but anyway that will not go 
into the changelog.

>   5 files changed, 44 insertions(+), 44 deletions(-)
>
> --- linux-2.6.orig/arch/arm/boot/dts/omap3-beagle.dts
> +++ linux-2.6/arch/arm/boot/dts/omap3-beagle.dts
> @@ -61,9 +61,9 @@
>   };
>
>   &mmc2 {
> -	status = "disable";
> +	status = "disabled";
>   };
>
>   &mmc3 {
> -	status = "disable";
> +	status = "disabled";
>   };
> --- linux-2.6.orig/arch/arm/boot/dts/omap4-panda.dts
> +++ linux-2.6/arch/arm/boot/dts/omap4-panda.dts
> @@ -74,15 +74,15 @@
>   };
>
>   &mmc2 {
> -	status = "disable";
> +	status = "disabled";
>   };
>
>   &mmc3 {
> -	status = "disable";
> +	status = "disabled";
>   };
>
>   &mmc4 {
> -	status = "disable";
> +	status = "disabled";
>   };
>
>   &mmc5 {
> --- linux-2.6.orig/arch/arm/boot/dts/omap4-sdp.dts
> +++ linux-2.6/arch/arm/boot/dts/omap4-sdp.dts
> @@ -147,11 +147,11 @@
>   };
>
>   &mmc3 {
> -	status = "disable";
> +	status = "disabled";
>   };
>
>   &mmc4 {
> -	status = "disable";
> +	status = "disabled";
>   };
>
>   &mmc5 {
>
