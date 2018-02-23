From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Feb 2018 10:25:57 +0100
Subject: [PATCH 5/6] arm64: dts: renesas: r8a77965: Add #pwm-cells property
In-Reply-To: <1519326370-15805-6-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519326370-15805-6-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdUtb7kHbZ-z7JMKfAQZ-cyQaPPeOitwV=WSns+Y7hZkSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add "#pwm-cells" property to "pwm at e6e31000" device node.
>
> This silences the following DTC compiler warning:
> Warning (pwms_property): Missing property '#pwm-cells' in node
> /soc/pwm at e6e31000 or bad phandle (referred from /backlight:pwms[0])
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
