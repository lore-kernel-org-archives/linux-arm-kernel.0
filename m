From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 17 Nov 2017 18:00:46 +0000
Subject: [PATCH] dt-bindings: qspi: Add r8a7743/5 to the compatible list
In-Reply-To: <1504858035-3568-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1504858035-3568-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TY1PR06MB08958546062D685532669977C02F0@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

this patch has been around for some time now, it was reviewed-by Geert Uytterhoeven and acked-by Rob Herring, any news?

Thanks,
Fab

> Subject: [PATCH] dt-bindings: qspi: Add r8a7743/5 to the compatible list
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-rspi.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
> index 8f4169f..3b02b3a 100644
> --- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
> @@ -5,11 +5,14 @@ Required properties:
>       "renesas,rspi-<soctype>", "renesas,rspi" as fallback.
>       For Renesas Serial Peripheral Interface on RZ/A1H:
>       "renesas,rspi-<soctype>", "renesas,rspi-rz" as fallback.
> -     For Quad Serial Peripheral Interface on R-Car Gen2:
> +     For Quad Serial Peripheral Interface on R-Car Gen2 and
> +     RZ/G1 devices:
>       "renesas,qspi-<soctype>", "renesas,qspi" as fallback.
>       Examples with soctypes are:
>          - "renesas,rspi-sh7757" (SH)
>  - "renesas,rspi-r7s72100" (RZ/A1H)
> +- "renesas,qspi-r8a7743" (RZ/G1M)
> +- "renesas,qspi-r8a7745" (RZ/G1E)
>  - "renesas,qspi-r8a7790" (R-Car H2)
>  - "renesas,qspi-r8a7791" (R-Car M2-W)
>  - "renesas,qspi-r8a7792" (R-Car V2H)
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
