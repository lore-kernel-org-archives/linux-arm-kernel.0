From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 5 Jul 2017 12:18:01 +0200
Subject: [PATCH v2] arm64: dts: r8a7795: add IMR-LX4 support
In-Reply-To: <20170627173152.532417992@cogentembedded.com>
References: <20170627173152.532417992@cogentembedded.com>
Message-ID: <CAMuHMdV9o0HhZgJS2cyWPmsdqgRmXpjSfKrKQMN=x5VTpXZoUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Jun 27, 2017 at 7:30 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Describe the IMR-LX4 devices in the R8A7795 device tree.
>
> Based on the original (and large) patch by Konstantin Kozhevnikov
> <Konstantin.Kozhevnikov@cogentembedded.com>.
>
> Signed-off-by: Konstantin Kozhevnikov <Konstantin.Kozhevnikov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> ---
> This patch is against the 'renesas-devel-20170626-v4.12-rc7' tag of Simon
> Horman's 'renesas.git' repo.
>
> The IMR-LX4 bindings were documented in the IMR driver patch and ACK'ed by Rob
> Herring, so I don't expect them to change...
>
> Changes in version 2:
> - added SoC specific "compatible" prop values;
> - refreshed the patch;
> - added Geert's tag.

In the mean time, r8a7795.dtsi gained reset controller support, so
you should add "resets" properties were appropriate.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
