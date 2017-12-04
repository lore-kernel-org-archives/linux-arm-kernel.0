From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 4 Dec 2017 11:00:48 +0100
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77970: use CPG core clock
 macros
In-Reply-To: <20171128202105.552196002@cogentembedded.com>
References: <20171128202105.552196002@cogentembedded.com>
Message-ID: <CAMuHMdW9arTM-JKimPgo3jJ3pQdGG2a1k1wpm2wRKYPGP=aJNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 9:15 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Now that the commit ecadea00f588 ("dt-bindings: clock: Add R8A77970 CPG
> core clock definitions") has hit Linus' tree, we  can replace the bare
> numbers (we had to use to avoid a cross tree dependency) with these macro
> definitions...
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
