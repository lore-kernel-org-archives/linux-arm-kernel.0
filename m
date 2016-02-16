From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 16 Feb 2016 07:37:00 +0100
Subject: [PATCH] ARM: dts: r8a7794: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <1455572925-27697-1-git-send-email-horms+renesas@verge.net.au>
References: <1455572925-27697-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWo-tRQCRfDRrceAPaHMBMtPe15tPnMH1yjkhjpDwTSaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 10:48 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
> check for/support the legacy "gpio-key,wakeup" boolean property to
> enable gpio buttons as wakeup source, "wakeup-source" is the new
> standard binding.
>
> This patch replaces the legacy "gpio-key,wakeup" with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.
>
> Changelog text from a similar patch by Sudeep Holla.
>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
