From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 18 Jul 2014 21:27:28 +0400
Subject: [PATCH v10 2/8] Documentation: bindings: add the Berlin SATA PHY
In-Reply-To: <1405686607-8126-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405686607-8126-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <53C95900.9050200@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/18/2014 04:30 PM, Antoine T?nart wrote:

> The Berlin SATA PHY drives the PHY related to the SATA interface. Add
> the corresponding documentation.

> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>   .../devicetree/bindings/phy/berlin-sata-phy.txt    | 34 ++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/berlin-sata-phy.txt

> diff --git a/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
> new file mode 100644
> index 000000000000..88f8c23384c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
> @@ -0,0 +1,34 @@
> +Berlin SATA PHY
> +---------------
> +
> +Required properties:
> +- compatible: should be "marvell,berlin2q-sata-phy"
> +- address-cells: should be 1
> +- size-cells: should be 0
> +- phy-cells: from the generic PHY bindings, must be 1

    It's "#address-cells", "#size-cells", and "#phy-cells".

> +- reg: address and length of the register
> +- clocks: reference to the clock entry
> +
> +Sub-nodes:
> +Each PHY should be represented as a sub-node.

    Then "#phy-cells" should also belong to the sub-nodes.

> +
> +Sub-nodes required properties:
> +- reg: the PHY number

WBR, Sergei
