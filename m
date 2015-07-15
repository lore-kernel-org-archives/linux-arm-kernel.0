From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 15 Jul 2015 09:43:40 +0200
Subject: [PATCH] ARM: shmobile: Enable fixed voltage regulator in
 shmobile_defconfig
In-Reply-To: <1436942555-4851-1-git-send-email-horms+renesas@verge.net.au>
References: <1436942555-4851-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdU+FBMGvAz10g=W80iR4O1d=f5+tsXw=nN=q3qw_F_NMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 8:42 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> This is selected by MACH_MARZEN which is enabled in shmobile_defconfig,
> however, MACH_MARZEN is going away along with the board code it enables.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
