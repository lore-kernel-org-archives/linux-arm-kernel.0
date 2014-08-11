From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 11 Aug 2014 09:11:22 +0200
Subject: [PATCH 1/5] ARM: shmobile: r8a7740: Add CMT1 device to DT
In-Reply-To: <1407725139-16156-2-git-send-email-horms+renesas@verge.net.au>
References: <1407725139-16156-1-git-send-email-horms+renesas@verge.net.au>
 <1407725139-16156-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWBdbeTAG9eB_kg63i=4jYKLK7_1iD_POVOLnDkVHCUDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 4:45 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add the CMT0 counters to the r8a7740 device tree and make it

CMT1?

> disabled by default.

> +       cmt1: timer at e6138000 {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
