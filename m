From: robh@kernel.org (Rob Herring)
Date: Tue, 14 Jun 2016 07:42:36 -0500
Subject: [PATCH 09/10] dt-bindings: clock: add DT binding for the
 peripheral clocks on Armada 3700
In-Reply-To: <1465565018-14172-10-git-send-email-gregory.clement@free-electrons.com>
References: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
 <1465565018-14172-10-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160614124236.GA2001@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 03:23:37PM +0200, Gregory CLEMENT wrote:
> This commit adds the DT binding documentation for the peripheral clocks
> used in the Marvell Armada 3700 SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../bindings/clock/armada3700-periph-clock.txt     | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
> new file mode 100644
> index 000000000000..549a5ad14031
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
> @@ -0,0 +1,70 @@
> +* Peripheral Clock bindings for Marvell Armada 37xx SoCs
> +
> +Marvell Armada 37xx SoCs provide peripheral clocks which are
> +used as clock source for the peripheral of the SoC.
> +
> +There are two different block associated to north bridge and south

s/block/blocks/

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
