From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 30 Sep 2014 09:22:44 +0200
Subject: [PATCH v2 5/5] m25p80,spi-nor: Share the list of supported chip
 type names again
In-Reply-To: <1412043352.9388.86.camel@decadent.org.uk>
References: <1412043222.9388.81.camel@decadent.org.uk>
 <1412043352.9388.86.camel@decadent.org.uk>
Message-ID: <CAMuHMdXRu0tMc1kbWfoVzh=Efky31zQEJDZtRUg_EHXdi-xCjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Tue, Sep 30, 2014 at 4:15 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> Move the list of chip type information to a macro in spi-nor.h, but
> leave the definitions of INFO and CAT25_INFO in spi-nor.
>
> In m25p80, define the INFO and CAT25_INFO macros to initialise a
> struct spi_device_id with the name, ignoring the remaining parameters.
>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Thanks!

I didn't have an in-depth look, but this looks much better, and has less
opportunities for getting out-of-sync.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
