From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 11 Dec 2014 09:56:20 +0100
Subject: [PATCH] ARM: shmobile: r8a7794: Add QSPI clock to device tree
In-Reply-To: <1418259561-27862-1-git-send-email-horms+renesas@verge.net.au>
References: <1418259561-27862-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXqHYxJbt=e8WKooJ5621eEOaxG3JkU4uAX9ZwG538UMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 1:59 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> [horms: omitted device node and alias; only add clock]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.a, not device nodes:u>

(After fixing renesas,clock-indices, as reported by Morimoto-san)

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
