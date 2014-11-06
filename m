From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Nov 2014 08:36:20 +0100
Subject: [PATCH] PM / Domains: Change prototype for the ->attach_dev()
 callback
In-Reply-To: <7hsihx1bvo.fsf@deeprootsystems.com>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
 <20141105013353.GA19238@dtor-ws>
 <7h7fz92rqk.fsf@deeprootsystems.com>
 <3267963.fqUYb7m9Rv@vostro.rjw.lan>
 <7hsihx1bvo.fsf@deeprootsystems.com>
Message-ID: <CAMuHMdWRXA6pXob=Hacosfic1jeLmo79T-YCKQ77aJbVisZm-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 6, 2014 at 12:11 AM, Kevin Hilman <khilman@kernel.org> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Thu, 30 Oct 2014 13:02:49 +0100
> Subject: [PATCH] PM / Domains: Change prototype for the attach and detach
>  callbacks
>
> Convert the prototypes to return an int in order to support error
> handling in these callbacks.
>
> Also, as suggested by Dmitry Torokhov, pass the domain pointer for use
> inside the callbacks, and so that they match the existing
> power_on/power_off callbacks which currently take the domain pointer.
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> [khilman: added domain as parameter to callbacks, as suggested by Dmitry]

OK, so back to the signature of the original version...

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
