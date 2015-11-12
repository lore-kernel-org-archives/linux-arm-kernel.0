From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 12 Nov 2015 11:44:15 +0100
Subject: [PATCH v2 3/3] ARM: shmobile: gose: Add QSPI device to DT
In-Reply-To: <1447291763-27527-4-git-send-email-horms+renesas@verge.net.au>
References: <1447291763-27527-1-git-send-email-horms+renesas@verge.net.au>
 <1447291763-27527-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWi=uTAtNvhSA54JDms_pLW0zjKQ_VH8xU3eY6BGiwV5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Nov 12, 2015 at 2:29 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Enable the QSPI controller in the gose device tree.
>
> Based similar work for the silk board by by Vladimir Barinov and
> Sergei Shtylyov.
>
> Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
> Tested: Read /dev/mtd0 with 512K blocks at 1.7MB/s

That's slow: I get 6.7 MB/s on koelsch (69.9 Mbps for Quad Read according
to my in-kernel QSPI debug code). Is this with SYS-DMAC enabled?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
