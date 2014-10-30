From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 30 Oct 2014 10:51:56 +0100
Subject: [PATCH 0/2] ARM: shmobile: r8a7790: Fix SD3CKCR address
In-Reply-To: <1414648677-31104-1-git-send-email-horms+renesas@verge.net.au>
References: <1414648677-31104-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWS1M24vngxvrf3mRGfVwKvmgsXnqZ6xq_hJuPC=KqqWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 6:57 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> This short series corrects the SD3CKCR address in both C and DT
>
> Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
>
> Shinobu Uehara (2):
>   ARM: shmobile: r8a7790: Fix SD3CKCR address
>   ARM: shmobile: r8a7790: Fix SD3CKCR address to device tree

This  matches my copy of the datasheet, so

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

But it would be good to know this has been verified on actual hardware.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
