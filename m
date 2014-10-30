From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 30 Oct 2014 13:17:30 +0100
Subject: [PATCH] PM / Domains: Change prototype for the ->attach_dev()
 callback
In-Reply-To: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdUnb-6zbLBWZa4Zdkqx7PQJLtMPotRNLFY+gRyyyGeX0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 1:02 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Convert the prototype to return and int. This is just an initial step,
> needed to support error handling.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
