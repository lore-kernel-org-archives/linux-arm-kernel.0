From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 02 Jul 2014 10:01:10 +0200
Subject: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7778
In-Reply-To: <1404274746-26098-1-git-send-email-horms+renesas@verge.net.au>
References: <1404274746-26098-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <2879829.a9Do9uWj60@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Wednesday 02 July 2014 06:19:06 Simon Horman wrote:
> Simply document a new compat string.
> There appears to be no need for a driver updates.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt index
> 64fd7de..8a50a2e 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -4,6 +4,7 @@ Required properties:
> 
>    - compatible: Must contain one of the following:
> 
> +    - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
>      - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
>      - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
>      - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.

-- 
Regards,

Laurent Pinchart
