From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 9 Dec 2015 11:42:35 +0100
Subject: [PATCH 1/2] ARM: shmobile: r8a7793: Add missing serial devices to
 DT
In-Reply-To: <1448589166-11612-2-git-send-email-horms+renesas@verge.net.au>
References: <1448589166-11612-1-git-send-email-horms+renesas@verge.net.au>
 <1448589166-11612-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUXaO6PynwOaEP9e88F10uJSoc7u848RgnDVRdqyYFnTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 2:52 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Instantiate all serial devices in r8a7793 device tree
> and set them as disabled by default.
>
> Based on similar work for the r8a7791 by Laurent Pinchart.
>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
