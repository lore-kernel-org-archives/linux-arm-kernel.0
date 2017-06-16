From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 16 Jun 2017 20:24:56 +0300
Subject: [PATCH] gpio: rcar: Add R8A7743 (RZ/G1M) support
In-Reply-To: <1497619944-61410-1-git-send-email-biju.das@bp.renesas.com>
References: <1497619944-61410-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <d7242a3b-bf30-1683-29e0-90c847ce8eaf@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 06/16/2017 04:32 PM, Biju Das wrote:

> Renesas RZ/G1M (R8A7743 SoC) GPIO blocks are identical to the R-Car Gen2

    SoC should be outside the parens.

> family. Add support for its GPIO controllers.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
>  drivers/gpio/gpio-rcar.c                                     | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> index 7c1ab3b..1cc3cfe 100644
> --- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> +++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> @@ -3,6 +3,7 @@
>  Required Properties:
>
>    - compatible: should contain one of the following.
> +    - "renesas,gpio-r8a7743": for R8A7743 (RZ-G1M) compatible GPIO controller.

    Not RZ/G1M?

[...]

MBR, Sergei
