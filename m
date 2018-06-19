From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 Jun 2018 14:58:10 +0200
Subject: [PATCH v2 0/5] crypto: ccree: cleanup, fixes and R-Car enabling
In-Reply-To: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
Message-ID: <CAMuHMdVXrppnFEBmR3xhwNu3i0N3mVE1+FJRjEcWBYpHHbsAsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gilad,

On Thu, May 24, 2018 at 4:19 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> The patch set enables the use of CryptoCell found in some Renesas R-Car
> Salvator-X boards and fixes some driver issues uncovered that prevented
> to work properly.

With DEBUG enabled on R-Car H3, I see lots of

    ccree e6601000.crypto: IRR includes unknown cause bits (0x00000098)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000C0)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D0)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D8)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000E0)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F0)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F8)

during boot. Is that expected?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
