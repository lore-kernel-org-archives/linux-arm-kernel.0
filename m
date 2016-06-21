From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 21 Jun 2016 09:10:55 +0200
Subject: [PATCH] ARM: dts: r8a7792: add SMP support
In-Reply-To: <1627631.X1bJtVQHBF@wasted.cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <1627631.X1bJtVQHBF@wasted.cogentembedded.com>
Message-ID: <CAMuHMdXQ9rN8Gp0geqiubjcniodtEdo2S6-fMJx0YLtgXZHuDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 12:31 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the device tree nodes for the Advanced Power Management Unit (APMU)
> and the second Cortex-A15 CPU core.
> Use the "enable-method" prop  to point out that the APMU should be used
> for the SMP support.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
