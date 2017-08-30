From: mpe@ellerman.id.au (Michael Ellerman)
Date: Wed, 30 Aug 2017 19:20:39 +1000
Subject: [PATCH v3 3/6] dt: booting-without-of: DT fix
 s/#interrupt-cell/#interrupt-cells/
In-Reply-To: <1496407129-13527-4-git-send-email-geert+renesas@glider.be>
References: <1496407129-13527-1-git-send-email-geert+renesas@glider.be>
 <1496407129-13527-4-git-send-email-geert+renesas@glider.be>
Message-ID: <87wp5l1kew.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Rob this has your ack, but I'd expect it to go via your tree? Or should
I grab it?

cheers

> diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
> index 280d283304bb82d8..f35d3adacb987f7d 100644
> --- a/Documentation/devicetree/booting-without-of.txt
> +++ b/Documentation/devicetree/booting-without-of.txt
> @@ -1309,7 +1309,7 @@ number and level/sense information. All interrupt children in an
>  OpenPIC interrupt domain use 2 cells per interrupt in their interrupts
>  property.
>  
> -The PCI bus binding specifies a #interrupt-cell value of 1 to encode
> +The PCI bus binding specifies a #interrupt-cells value of 1 to encode
>  which interrupt pin (INTA,INTB,INTC,INTD) is used.
>  
>  2) interrupt-parent property
> -- 
> 2.7.4
