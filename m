From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 14 Dec 2017 11:24:30 +0100
Subject: [PATCH 2/3] ARM: dts: r8a7791: Correct critical CPU temperature
In-Reply-To: <1513242521-11236-3-git-send-email-chris.paterson2@renesas.com>
References: <1513242521-11236-1-git-send-email-chris.paterson2@renesas.com>
 <1513242521-11236-3-git-send-email-chris.paterson2@renesas.com>
Message-ID: <CAMuHMdWwL4xMPRi3wJoBNdjc_UCjVYjqLP=Db-15mqM8FUAo4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 10:08 AM, Chris Paterson
<chris.paterson2@renesas.com> wrote:
> The R-Car M2W hardware manual states that Tc = ?40?C to +105?C. The

M2-W

> thermal sensor has an accuracy of ?5?C and there can be a temperature
> difference of 1 or 2 degrees between Tjmax and the thermal sensor due
> to the location of the latter.
>
> This means that 95?C is a safer value to use.
>
> Fixes: cac68a56e34b9810 ("ARM: dts: r8a7791: enable to use thermal-zone")
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
