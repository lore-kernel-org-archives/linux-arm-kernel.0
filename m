From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 14 Dec 2017 11:23:51 +0100
Subject: [PATCH 1/3] ARM: dts: r8a7790: Correct critical CPU temperature
In-Reply-To: <1513242521-11236-2-git-send-email-chris.paterson2@renesas.com>
References: <1513242521-11236-1-git-send-email-chris.paterson2@renesas.com>
 <1513242521-11236-2-git-send-email-chris.paterson2@renesas.com>
Message-ID: <CAMuHMdUp8SRe9-KhHA5CVTEJ_fvbdSj+-H0Ab76+DPVYVDEtxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 10:08 AM, Chris Paterson
<chris.paterson2@renesas.com> wrote:
> The R-Car H2 hardware manual states that Tc = ?40?C to +105?C. The
> thermal sensor has an accuracy of ?5?C and there can be a temperature
> difference of 1 or 2 degrees between Tjmax and the thermal sensor due
> to the location of the latter.
>
> This means that 95?C is a safer value to use.
>
> Fixes: a8b805f3606f7af7 ("ARM: dts: r8a7790: enable to use thermal-zone")
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
