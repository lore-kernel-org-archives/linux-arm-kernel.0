From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 4 Dec 2017 11:02:42 +0100
Subject: [PATCH 2/2] arm64: dts: renesas: r8a77970: use SYSC power domain
 macros
In-Reply-To: <20171128202109.031715810@cogentembedded.com>
References: <20171128202109.031715810@cogentembedded.com>
Message-ID: <CAMuHMdWAXwf2RLma7EN3c0oGVrRnV_XARFY51e-ebObC3-5Gig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 9:15 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Now that the commit 833bdb47c826 ("dt-bindings: power: add R8A77970 SYSC
> power domain definitions") has hit Linus' tree, we can replace the  bare
> numbers  (we had to use to avoid a cross tree dependency) with these macro
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
