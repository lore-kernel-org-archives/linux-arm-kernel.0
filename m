From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 22 Jan 2016 10:17:56 +0100
Subject: [PATCH 0/2] ARM: shmobile: r8a777[89]: use GIC_* defines
In-Reply-To: <1453351966-10968-1-git-send-email-horms+renesas@verge.net.au>
References: <1453351966-10968-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdU7FwRB4k=6oKq=eYDk9eOM6ffRinLv+TMNMpU0GsZWCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Jan 21, 2016 at 5:52 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> this short series uses GIC_* defines in the r8a779[34] device trees as
> appropriate.
>
> This is a follow-up for similar work for the r8a779[0134] SoCs.
> I plan to post follow up patches to update the device trees for
> other Renesas SoCs depending on the success of this series.
>
> Based on renesas-devel-20160118-v4.4

Thank you!

> Simon Horman (2):
>   ARM: dts: r8a7778: use GIC_* defines
>   ARM: dts: r8a7779: use GIC_* defines

Both
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
