From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 11:52:14 +0100
Subject: [PATCH 5/9] serial: pxa: Fix out-of-bounds access through DT alias
In-Reply-To: <1519119624-1268-6-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-6-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdX-9+7WRDP848Y6xwqF-iNGm6A32gKgTPFdsLY=5K2q9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 10:40 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The serial_pxa_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Fixes: c8dcdc77298dde67 ("serial: pxa: Fix out-of-bounds access through DT alias")

Fixes: 699c20f3e6310aa2 ("serial: pxa: add OF support")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
