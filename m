From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 Feb 2018 15:03:16 +0100
Subject: [PATCH 08/15] Documentation: devicetree: renesas,
 sci: Add r8a77965
In-Reply-To: <1518515162-23663-9-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-9-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdVEaq0P7L+iB7rFZYr-GYD8LPRvbvUtzJ8phbMcoDn+Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject prefix should be "dt-bindings: serial: sh-sci: "

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add documentation for r8a77965 compatible string to reneass sci-serial

Renesas

> device tree bindings documentation.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index cf504d0..cbb418a 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -40,7 +40,9 @@ Required properties:
>      - "renesas,scif-r8a7795" for R8A7795 (R-Car H3) SCIF compatible UART.
>      - "renesas,hscif-r8a7795" for R8A7795 (R-Car H3) HSCIF compatible UART.
>      - "renesas,scif-r8a7796" for R8A7796 (R-Car M3-W) SCIF compatible UART.
> +    - "renesas,scif-r8a77965" for R8A77965 (R-Car M3-N) SCIF compatible UART.
>      - "renesas,hscif-r8a7796" for R8A7796 (R-Car M3-W) HSCIF compatible UART.
> +    - "renesas,hscif-r8a77965" for R8A77965 (R-Car M3-N) HSCIF compatible UART.

Please keep both r8a77965 entries together, like is done for other SoCs.

>      - "renesas,scif-r8a77970" for R8A77970 (R-Car V3M) SCIF compatible UART.
>      - "renesas,hscif-r8a77970" for R8A77970 (R-Car V3M) HSCIF compatible UART.
>      - "renesas,scif-r8a77995" for R8A77995 (R-Car D3) SCIF compatible UART.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
