From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 7 Mar 2016 14:22:57 +0100
Subject: [PATCH] bus: simple-pm-bus: Use ARCH_RENESAS
In-Reply-To: <20160304052019.GD27942@verge.net.au>
References: <1456969198-20365-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVU1RPAafTbUpw6CyW-tQ1amHeiR2DGY_QK8vTFEXpHTA@mail.gmail.com>
 <20160304052019.GD27942@verge.net.au>
Message-ID: <CAMuHMdVjpYg1q_ZGm7tVASvrAE8oEzVZFTtua4LVDFsY7cHCVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 4, 2016 at 6:20 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Mar 03, 2016 at 09:31:49AM +0100, Geert Uytterhoeven wrote:
>> On Thu, Mar 3, 2016 at 2:39 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
>> > Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>> >
>> > This is part of an ongoing process to migrate from ARCH_SHMOBILE to
>> > ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
>> > appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>> >
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I'm a little unsure of who should take this but for now I will
> queue it up in next with a view to sending a pull request to Linus
> for v4.6. I'm open to other ideas.

All but two entries in drivers/bus/Kconfig are for ARM platforms (the other two
are for MIPS platforms), so I think arm-soc is appropriate.

Alternatively, GregKH?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
