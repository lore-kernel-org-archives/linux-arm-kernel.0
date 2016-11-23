From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 23 Nov 2016 14:10:23 +0100
Subject: [PATCH 1/3] arm64: dts: r8a7796: Add CAN external clock support
In-Reply-To: <1479903264-1909-1-git-send-email-chris.paterson2@renesas.com>
References: <1479903264-1909-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <CAMuHMdVsj9XWUNkLTrBMKSLjy_o769j5_vOu7f+zi9pUynkP0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 1:14 PM, Chris Paterson
<chris.paterson2@renesas.com> wrote:
> Adds external CAN clock node for r8a7796. This clock can be used as
> fCAN clock of CAN and CAN FD controller.
>
> Based on a patch for r8a7795 by Ramesh Shanmugasundaram.
>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
