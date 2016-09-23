From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 17:37:48 -0500
Subject: [PATCH v4] devicetree: bindings: uart: Add new compatible string
 for ZynqMP
In-Reply-To: <1474629948-9780-1-git-send-email-navam@xilinx.com>
References: <1474629948-9780-1-git-send-email-navam@xilinx.com>
Message-ID: <20160923223747.GA1163@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 04:55:48PM +0530, Nava kishore Manne wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> This patch Adds the new compatible string for ZynqMP.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
> Changes for v4:
> 		-Modified the ChangeLog comment.
> Changes for v3:
> 		-Added changeLog comment.
> Changes for v2:
>                 -None
> 
>  Documentation/devicetree/bindings/serial/cdns,uart.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> index a3eb154..4fe7aae 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> @@ -1,7 +1,8 @@
>  Binding for Cadence UART Controller
>  
>  Required properties:
> -- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
> +- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps" for Zynq and
> +               "cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC uart controller.

Please format this as one valid combination per line.

xuartps is not very specific. It needs some abbreviation of "Zynq 
Ultrascale+ MPSoC" in it.

>  - reg: Should contain UART controller registers location and length.
>  - interrupts: Should contain UART controller interrupts.
>  - clocks: Must contain phandles to the UART clocks
> -- 
> 2.1.2
> 
