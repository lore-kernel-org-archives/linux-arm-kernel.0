From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 17 Apr 2018 17:49:25 +0200
Subject: [PATCH v5 3/6] dt-bindings: arm: Document the RZN1D-DB board
In-Reply-To: <1523963101-56725-4-git-send-email-michel.pollet@bp.renesas.com>
References: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523963101-56725-4-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <CAMuHMdU4upXcYZ_yD2a_=J5VAUE28fni7_NotmchjpYUqCxV=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

On Tue, Apr 17, 2018 at 1:04 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This documents the RZ/N1 bindings for the RZN1D-DB board.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index 61b486f..6efb3f1 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -51,7 +51,8 @@ SoCs:
>      compatible = "renesas,r8a77990"
>    - R-Car D3 (R8A77995)
>      compatible = "renesas,r8a77995"
> -
> +  - RZ/N1D (R9A06G032)
> +    compatible = "renesas,r9a06g032", "renesas,rzn1"

Why do you need a family-specific compatible value ("renesas,rzn1",
which is a marketing name)?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
