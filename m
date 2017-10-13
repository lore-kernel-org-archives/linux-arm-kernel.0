From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 Oct 2017 11:06:13 +0200
Subject: [PATCH/RFC 3/5] mfd: bd9571mwv: Allow DDR Backup Power register
 access
In-Reply-To: <20171013085851.ljvgmyd6ei2tv5fw@dell>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-4-git-send-email-geert+renesas@glider.be>
 <20171013085851.ljvgmyd6ei2tv5fw@dell>
Message-ID: <CAMuHMdVZiaq40r0Su01n9C7oXR7i_QWmNhZtY7Udhy9gdYHVRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, Oct 13, 2017 at 10:58 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 10 Oct 2017, Geert Uytterhoeven wrote:
>
>> Enable read/write access to the BD9571MWV_BKUP_MODE_CNT register, which
>> is a.o. used to configure DDR Backup Power.
>
> a.o.?  That's a new one on me.

among(st) others

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
