From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 29 Nov 2017 14:46:50 +0800
Subject: [PATCH v3 1/2] of: documentation: add bindings documentation for
 TS-7970
In-Reply-To: <20171123202446.587-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20171123202446.587-1-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <20171129064650.GI9376@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 03:24:45PM -0500, Sebastien Bourdelin wrote:
> This adds the documentation for the TS-7970 by Technologic Systems.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>

It needs to be acked by DT maintainer.  I see devicetree list is not on
copy, and that could be the reason why there is no ack from DT
maintainer?

Shawn

> ---
> Changes v1 -> v2:
>   - rebase on master
> ---
>  Documentation/devicetree/bindings/arm/technologic.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
> index 33797acad846..187830bd4f51 100644
> --- a/Documentation/devicetree/bindings/arm/technologic.txt
> +++ b/Documentation/devicetree/bindings/arm/technologic.txt
> @@ -10,3 +10,9 @@ It can be mounted on a carrier board providing additional peripheral connectors.
>  Required root node properties:
>  	- compatible = "technologic,imx6dl-ts4900", "fsl,imx6dl"
>  	- compatible = "technologic,imx6q-ts4900", "fsl,imx6q"
> +
> +TS-7970 is a System-on-Module based on the Freescale i.MX6 System-on-Chip.
> +It can be mounted on a carrier board providing additional peripheral connectors.
> +Required root node properties:
> +	- compatible = "technologic,imx6dl-ts7970", "fsl,imx6dl"
> +	- compatible = "technologic,imx6q-ts7970", "fsl,imx6q"
> -- 
> 2.15.0
> 
