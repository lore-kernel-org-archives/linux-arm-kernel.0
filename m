From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Oct 2014 09:57:03 +0200
Subject: [PATCH 3/6] dt-bindings: Document Broadcom Cygnus SoC and clock
 driver
In-Reply-To: <1412746025-11998-4-git-send-email-sbranden@broadcom.com>
References: <1412746025-11998-4-git-send-email-sbranden@broadcom.com>
Message-ID: <2480056.Cs3dr8EM2e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 October 2014 22:27:02 Scott Branden wrote:
> diff --git a/Documentation/devicetree/bindings/arm/cygnus.txt b/Documentation/devicetree/bindings/arm/cygnus.txt
> new file mode 100644
> index 0000000..a210377
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cygnus.txt
> @@ -0,0 +1,12 @@
> +Broadcom Cygnus device tree bindings
> +------------------------------------
> +
> +All Cygnus boards shall have the following properties:
> +
> +Required root node property:
> +       - compatible = "brcm,cygnus";

Can you add a more specific model number for the soc as well?
I assume that cygnus refers to more than one model, so you
should probably list both the family and the individual
SoC type here.

> +Boards variants shall have the following additional properties:
> +
> +Required root node property for the BCM911360_ENTPHN board:
> +       - compatible = "brcm,bcm911360_entphn";
> 

We normally don't list specific boards here, since it's hard to
keep up.

	Arnd
