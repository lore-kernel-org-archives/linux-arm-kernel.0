From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 Apr 2016 09:18:55 +0200
Subject: [PATCH] ARM: dts: r8a7791: Don't disable referenced optional
 clocks
In-Reply-To: <1459947173-6664-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1459947173-6664-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <CAMuHMdWcsi0XE6htZW=V5DDKy8LX_1rdBoo_dEeDBvLcDeMFvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 6, 2016 at 2:52 PM, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> clk_get on a disabled clock node will return EPROBE_DEFER, which can
> cause drivers to be deferred forever if such clocks are referenced in
> their clocks property.
>
> Update the various disabled external clock nodes to default to a
> frequency of 0, but don't disable them to prevent this.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
