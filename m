From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Jan 2015 14:41:33 +0100
Subject: [PATCH v2] ARM: shmobile: r8a7791: add ADSP clocks
In-Reply-To: <4692589.Khlcz7yVTN@wasted.cogentembedded.com>
References: <4692589.Khlcz7yVTN@wasted.cogentembedded.com>
Message-ID: <CAMuHMdWeGRZ_aTHyiE9ajmHarfBtZG+k3fr6uBXyYZjOB+GaTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 9:20 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the ADSP clocks to the CPG and MSTP5 nodes of the R8A7791 device tree.
>
> Based on the original patch by Konstantin Kozhevnikov
> <konstantin.kozhevnikov@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
