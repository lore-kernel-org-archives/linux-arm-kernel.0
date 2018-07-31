From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 31 Jul 2018 08:45:11 +0200
Subject: [PATCH] arm64: dts: renesas: r8a779{7|8}0: move CAN clock node
In-Reply-To: <fe596579-e541-f061-4ef7-bf850b24153a@cogentembedded.com>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
 <fe596579-e541-f061-4ef7-bf850b24153a@cogentembedded.com>
Message-ID: <CAMuHMdUEh+wSXqUn5yBb=Z9prN0=5pKM9VyPNg4hv1dZf97xRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 8:22 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The CAN clock node should precede the "cpus" node in the R8A779{7|8}0
> device  trees,  according to  the alphanumeric node sorting rule...
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
