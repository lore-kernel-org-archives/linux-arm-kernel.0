From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 Feb 2018 15:10:27 +0100
Subject: [PATCH 12/15] ARM64: dts: r8a77965: Add GPIO nodes
In-Reply-To: <1518515162-23663-13-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-13-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdWptGc4hG4yufgbjnfu-4vyD8Hag-01FhWW_ubojXNHiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add GPIO nodes to r8a77965 SoC device tree file.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -201,38 +201,6 @@
>                         #power-domain-cells = <1>;
>                 };
>
> -               gpio0: gpio at e6050000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio1: gpio at e6051000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio2: gpio at e6052000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio3: gpio at e6053000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio4: gpio at e6054000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio5: gpio at e6055000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio6: gpio at e6055400 {
> -                       /* placeholder */
> -               };
> -
> -               gpio7: gpio at e6055800 {
> -                       /* placeholder */
> -               };
> -
>                 intc_ex: interrupt-controller at e61c0000 {
>                         /* placeholder */
>                 };
> @@ -339,6 +307,126 @@
>                         dma-channels = <16>;
>                 };
>
> +               gpio0: gpio at e6050000 {

Why have you moved them?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
