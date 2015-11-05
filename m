From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 5 Nov 2015 19:58:46 +0100
Subject: [PATCH/RFC] ARM: shmobile: Introduce ARCH_RENESAS
In-Reply-To: <1446702397-24078-1-git-send-email-horms+renesas@verge.net.au>
References: <1446702397-24078-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXQ5tvWu4dizhpkAx1Uhq9cSM8mj2JhWJUSxDx+Jyk2tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2015 at 6:46 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> The purpose of this patch is to start the process of replacing both
> ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI with ARCH_RENESAS. The motivation
> being that as time has moved on Renesas has become a name than shmobile for
> the majority Renesas 32-bit ARM based SoCs. The name is, conveniently, also
> applicable to (older) Renesas SH based SoCs and (newer) ARM64 based SoCs
> although this patch only addresses 32-bit ARM.

Is this supposed to include H8/300 and m32r in the future?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
