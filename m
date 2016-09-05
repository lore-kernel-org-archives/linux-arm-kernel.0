From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Sep 2016 11:50:41 +0200
Subject: [PATCH] ARM: dts: r8a7794: fix PWM clock parent
In-Reply-To: <1994467.CVFvpbaMyF@wasted.cogentembedded.com>
References: <1618499.8bcj8adpVO@wasted.cogentembedded.com>
 <1994467.CVFvpbaMyF@wasted.cogentembedded.com>
Message-ID: <CAMuHMdVezsJ1q0A4TCdhfEEPtnyMeXGGZxRREQucy6kr2BO=EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 4, 2016 at 9:55 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> When removing the non-existing thermal clock I forgot to remove its
> parent from the node's "clocks" property  -- this led to a wrong PWM
> clock's parent clock.
>
> Fixes: 2a29f9d6fea8 ("ARM: dts: r8a7794: add MSTP5 clocks")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
