From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 Aug 2017 15:59:16 +0200
Subject: [PATCH v2 3/3] arm64: dts: r8a7795: Use R-Car SATA Gen3 fallback
 compat string
In-Reply-To: <1502267203-12229-4-git-send-email-horms+renesas@verge.net.au>
References: <1502267203-12229-1-git-send-email-horms+renesas@verge.net.au>
 <1502267203-12229-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdX26bRY-n+PENFqXQ-D7t9EfnVTEbYNESg1u4VR4i4yDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 9, 2017 at 10:26 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use newly added R-Car SATA Gen3 fallback compat string
> in the DT of the r8a7795 SoC.
>
> This should have no run-time effect as the driver matches against
> the per-SoC compat string before the fallback compat string is considered.
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
