From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 31 May 2016 09:17:09 +0200
Subject: [PATCH v3 0/2] [media] atmel-isc: add driver for Atmel ISC
In-Reply-To: <1464677903-28412-1-git-send-email-songjun.wu@atmel.com>
References: <1464677903-28412-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <CAMuHMdV5pqAEea7v7WbQ2FSSve92avte4B=j53-12s842D-Xdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Songjun,

On Tue, May 31, 2016 at 8:58 AM, Songjun Wu <songjun.wu@atmel.com> wrote:
> The Image Sensor Controller driver includes two parts.
> 1) Driver code to implement the ISC function.
> 2) Device tree binding documentation, it describes how
>    to add the ISC in device tree.

Please reduce the CC list. Not everyone who ever touched a line in the
files you modified is working on media or atmel devices.

get_maintainer.pl gives hints, not exact lists of people.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
