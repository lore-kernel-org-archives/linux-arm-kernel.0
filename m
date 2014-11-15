From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sat, 15 Nov 2014 12:32:00 +0100
Subject: [PATCH] PM / Domains: Change prototype for the ->attach_dev()
 callback
In-Reply-To: <1442757.2EcII903db@vostro.rjw.lan>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
 <3267963.fqUYb7m9Rv@vostro.rjw.lan>
 <7hsihx1bvo.fsf@deeprootsystems.com>
 <1442757.2EcII903db@vostro.rjw.lan>
Message-ID: <CAMuHMdXHhcvar2RWVVXKwvqr1dbTnnZqbBYic53U3E8-EkcAjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Sat, Nov 15, 2014 at 12:48 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> Subject: [PATCH] PM / Domains: Change prototype for the attach and detach
>>  callbacks
>>
>> Convert the prototypes to return an int in order to support error
>> handling in these callbacks.
>>
>> Also, as suggested by Dmitry Torokhov, pass the domain pointer for use
>> inside the callbacks, and so that they match the existing
>> power_on/power_off callbacks which currently take the domain pointer.
>>
>> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> [khilman: added domain as parameter to callbacks, as suggested by Dmitry]
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>
> That's in the Linus' tree now.

Thank you very much.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
