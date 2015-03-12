From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 12 Mar 2015 09:03:04 +0100
Subject: [PATCH 0/2] ARM: shmobile: Correct SYSCIER values
In-Reply-To: <1426132537-31606-1-git-send-email-horms+renesas@verge.net.au>
References: <1426132537-31606-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUuv6YrEUsCpbuZwHUy_a-+sK8O=q8k-OZLZRytKv7gyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Mar 12, 2015 at 4:55 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> this short series corrects the SYSCIER value used on the r9a7790 and
> r8a7791 SoCs.

Thanks!

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> I am not aware of any run-time effect of these changes.

They only matter when powering up/down SYSC PM Domains, which is not
yet implemented for R-Car Gen2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
