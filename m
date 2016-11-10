From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 10 Nov 2016 11:56:12 +0100
Subject: [PATCH v2 0/7] soc: renesas: Identify SoC and register with the
 SoC bus
In-Reply-To: <CAMuHMdWox5ksj1xhJ6_n0wNA9j6veX0AzAE0V9Gs26Kvw5C_sw@mail.gmail.com>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <1626072.dpWPnWgGl9@wuerfel>
 <CAMuHMdVrdjqWruY=dBjWP=jZuZkc=aTBTMijOyTDfZFcaD_jsA@mail.gmail.com>
 <6723536.97ljqcB8tS@wuerfel>
 <CAMuHMdWox5ksj1xhJ6_n0wNA9j6veX0AzAE0V9Gs26Kvw5C_sw@mail.gmail.com>
Message-ID: <CAMuHMdWPk7zZKAHtxcYekS2Ot6j+M8dKJuFe87dxc7U6Z4Ti5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 10:22 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Thanks, I've created the branch/tag :
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
>     branch soc-device-match
>     signed tag soc-device-match-tag1

Tested by kbuild test robot:

    https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
 soc-device-match
    da65a1589dacc7ec44ea0557a14d70a39d991f32  base: soc: Provide a
dummy implementation of soc_device_match()
    elapsed time: 101m
    configs tested: 85

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
