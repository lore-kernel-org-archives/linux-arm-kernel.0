From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Oct 2014 10:29:52 +0200
Subject: [PATCH 04/44] m68k: Replace mach_power_off with pm_power_off
In-Reply-To: <1412659726-29957-5-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-5-git-send-email-linux@roeck-us.net>
Message-ID: <CAMuHMdVK+h0DAysDrfYQSwN9zjygTpHRkdkfeDucyoTBN5f=+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 7, 2014 at 7:28 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> Replace mach_power_off with pm_power_off to simplify the subsequent
> move of pm_power_off to generic code.

Thanks!

> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greg Ungerer <gerg@uclinux.org>
> Cc: Joshua Thompson <funaho@jurai.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Looks OK, so since you said it builds ;-)

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
