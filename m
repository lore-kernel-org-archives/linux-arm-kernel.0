From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Nov 2015 10:43:20 -0600
Subject: [PATCH 01/10] dt-bindings: create arm/nxp folder and move
 LPC32xx SoC description to it
In-Reply-To: <1447982925-30138-2-git-send-email-vz@mleia.com>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
 <1447982925-30138-2-git-send-email-vz@mleia.com>
Message-ID: <20151120164320.GA10936@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 03:28:36AM +0200, Vladimir Zapolskiy wrote:
> Create a separate folder for device tree bindings of NXP SoCs devices,
> and move lpc32xx.txt to it.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/arm/lpc32xx.txt     | 8 --------
>  Documentation/devicetree/bindings/arm/nxp/lpc32xx.txt | 8 ++++++++

This one is short, but use git-format-patch -M option in the future.

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 8 insertions(+), 8 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/lpc32xx.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/nxp/lpc32xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/lpc32xx.txt b/Documentation/devicetree/bindings/arm/lpc32xx.txt
> deleted file mode 100644
> index 56ec8dd..0000000
> --- a/Documentation/devicetree/bindings/arm/lpc32xx.txt
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -NXP LPC32xx Platforms Device Tree Bindings
> -------------------------------------------
> -
> -Boards with the NXP LPC32xx SoC shall have the following properties:
> -
> -Required root node property:
> -
> -compatible: must be "nxp,lpc3220", "nxp,lpc3230", "nxp,lpc3240" or "nxp,lpc3250"
> diff --git a/Documentation/devicetree/bindings/arm/nxp/lpc32xx.txt b/Documentation/devicetree/bindings/arm/nxp/lpc32xx.txt
> new file mode 100644
> index 0000000..56ec8dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/nxp/lpc32xx.txt
> @@ -0,0 +1,8 @@
> +NXP LPC32xx Platforms Device Tree Bindings
> +------------------------------------------
> +
> +Boards with the NXP LPC32xx SoC shall have the following properties:
> +
> +Required root node property:
> +
> +compatible: must be "nxp,lpc3220", "nxp,lpc3230", "nxp,lpc3240" or "nxp,lpc3250"
> -- 
> 2.1.4
> 
