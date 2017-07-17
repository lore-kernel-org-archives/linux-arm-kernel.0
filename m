From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 17 Jul 2017 10:09:28 +0200
Subject: [PATCH 2/3] ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding
 for vin nodes
In-Reply-To: <1499777809-27492-3-git-send-email-horms+renesas@verge.net.au>
References: <1499777809-27492-1-git-send-email-horms+renesas@verge.net.au>
 <1499777809-27492-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVrjsU8=1UmK-SNG316sDDpMehwFu+zJFBDjMFUptjjYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 2:56 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use R-Car Gen 2 fallback binding for vind nodes in DT for r8a7791 SoC.
>
> This has no run-time effect for the current driver as the initialisation
> sequence is the same for the SoC-specific binding for r8a7791 and the
> fallback binding for R-Car Gen 2
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
