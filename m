From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 04 Jul 2014 16:48:42 +0400
Subject: [PATCH v2 2/2] ARM: dts: at_xdmac: add bindings documentation
In-Reply-To: <1404459370-3540-3-git-send-email-ludovic.desroches@atmel.com>
References: <1404459370-3540-1-git-send-email-ludovic.desroches@atmel.com>
 <1404459370-3540-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <53B6A2AA.4000202@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/04/2014 11:36 AM, Ludovic Desroches wrote:

> Add bindings documentation for the new Atmel DMA controller (XDMAC)
> introduced with SAMA5D4.

> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>   .../devicetree/bindings/dma/atmel-xdma.txt         |   39 ++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dma/atmel-xdma.txt

> diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
> new file mode 100644
> index 0000000..1e09fda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
[...]
> +DMA clients connected to the Atmel XDMA controller must use the format
> +described in the dma.txt file, using a three-cell specifier for each channel:
> +a phandle plus two integer cells.

    Specifiers do not include phandle.

> +The two cells in order are:

    s/two/three/?

> +
> +1. A phandle pointing to the DMA controller.
> +2. The memory interface (16 most significant bits), the peripheral interface
> +(16 less significant bits).
> +3. Channel configuration register. Configurable fields are:
> +  - bit 30-24: PERID, peripheral identifier.

WBR, Sergei
