From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 22 Mar 2017 14:25:49 +0100
Subject: [PATCH v2 1/4] pinctrl: sh-pfc: Update info pointer after
 SoC-specific init
In-Reply-To: <1489425167-22711-2-git-send-email-geert+renesas@glider.be>
References: <1489425167-22711-1-git-send-email-geert+renesas@glider.be>
 <1489425167-22711-2-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdUYr8BTLdSLV=_JUJVvtDL0dc0PGq0M98Gf=6NtwdiL_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 6:12 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Update the sh_pfc_soc_info pointer after calling the SoC-specific
> initialization function, as it may have been updated to e.g. handle
> different SoC revisions.  This makes sure the correct subdriver name is
> printed later.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Queued in sh-pfc-for-v4.12 with
Fixes: 0c151062f32c9db8 ("sh-pfc: Add support for SoC-specific initialization")
as this has been reported independently afterwards.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
