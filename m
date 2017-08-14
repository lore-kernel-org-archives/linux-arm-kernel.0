From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 Aug 2017 15:53:53 +0200
Subject: [PATCH 09/10] arm64: dts: r8a7795: Use R-Car GPIO Gen3 fallback
 compat string
In-Reply-To: <1502181568-12299-10-git-send-email-horms+renesas@verge.net.au>
References: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
 <1502181568-12299-10-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUFJaaj_vNnv=0TakXQnV2=fw-ofGB5Zj8sVw9+ukWRnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 8, 2017 at 10:39 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use newly added R-Car GPIO Gen3 fallback compat string
> in place of now deprecated non-generation specific
> R-Car GPIO fallback compat string in the DT of the r8a7795 SoC.
>
> This should have no run-time effect as the driver matches against
> the per-SoC compat string before considering the fallback compat string.
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
