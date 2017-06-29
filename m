From: robh@kernel.org (Rob Herring)
Date: Thu, 29 Jun 2017 15:10:51 -0500
Subject: [PATCH 4/6] dt-bindings: serial: Document RDA Micro UART
In-Reply-To: <20170627005520.23731-5-afaerber@suse.de>
References: <20170627005520.23731-1-afaerber@suse.de>
 <20170627005520.23731-5-afaerber@suse.de>
Message-ID: <20170629201051.cfr37kh2gozompqo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 02:55:18AM +0200, Andreas F?rber wrote:
> Add an initial binding for the RDA8810PL UART.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/serial/rda-uart.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/rda-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/rda-uart.txt b/Documentation/devicetree/bindings/serial/rda-uart.txt
> new file mode 100644
> index 000000000000..6840a8aee035
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/rda-uart.txt
> @@ -0,0 +1,13 @@
> +RDA Micro UART
> +
> +Required properties:
> +- compatible :  "rda,8810pl-uart" for RDA8810PL
> +- reg        :  Offset and length of the register set for the device.

No clocks or interrupts?

Rob
