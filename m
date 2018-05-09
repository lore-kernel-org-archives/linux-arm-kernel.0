From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 9 May 2018 20:29:19 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: add resets property CAN-FD
 node
In-Reply-To: <20180509175409.10507-1-horms+renesas@verge.net.au>
References: <20180509175409.10507-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXWHXtO1-0FucCsPTE22U_k+vdqCrDHgBFrM4+yEgXYcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2018 at 7:54 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> Add resets property to CAN-FD node to describe it in the reset topology of
> on-SoC devices.  This allows to reset the CAN-FD device using the Reset
> Controller API.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
