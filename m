From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 Sep 2016 10:18:46 +0200
Subject: [PATCH RFC 6/8] ARM: dts: r8a7743: add SYS-DMAC support
In-Reply-To: <1815255.1arMxK7TDL@wasted.cogentembedded.com>
References: <3533019.Wim1Kuh1ic@wasted.cogentembedded.com>
 <1815255.1arMxK7TDL@wasted.cogentembedded.com>
Message-ID: <CAMuHMdXDFp_o8kgTuHyM_+kFhHL2NJxThNpoBz7=nv6FH3D0EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 3:36 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Describe SYS-DMAC0/1 in the R8A7743 device tree.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

(but the clocks properties will have to be changed due to CPG/MSSR)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
