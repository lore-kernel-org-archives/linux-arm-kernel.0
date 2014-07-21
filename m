From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 21 Jul 2014 11:04:23 +0200
Subject: [PATCH v10 2/8] Documentation: bindings: add the Berlin SATA PHY
In-Reply-To: <53C95900.9050200@cogentembedded.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405686607-8126-3-git-send-email-antoine.tenart@free-electrons.com>
 <53C95900.9050200@cogentembedded.com>
Message-ID: <20140721090423.GD32208@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 18, 2014 at 09:27:28PM +0400, Sergei Shtylyov wrote:
> On 07/18/2014 04:30 PM, Antoine T?nart wrote:
> 
> >diff --git a/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
> >new file mode 100644
> >index 000000000000..88f8c23384c0
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
> >@@ -0,0 +1,34 @@
> >+Berlin SATA PHY
> >+---------------
> >+
> >+Required properties:
> >+- compatible: should be "marvell,berlin2q-sata-phy"
> >+- address-cells: should be 1
> >+- size-cells: should be 0
> >+- phy-cells: from the generic PHY bindings, must be 1
> 
>    It's "#address-cells", "#size-cells", and "#phy-cells".

Sure.

> 
> >+- reg: address and length of the register
> >+- clocks: reference to the clock entry
> >+
> >+Sub-nodes:
> >+Each PHY should be represented as a sub-node.
> 
>    Then "#phy-cells" should also belong to the sub-nodes.

No, because the PHY provider is still the parent.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
