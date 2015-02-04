From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 4 Feb 2015 15:21:27 +0100
Subject: imx_v6_v7_defconfig needs lzop
Message-ID: <CAMuHMdVjqp52BQqH32Ut7kxDYzmyY4+JEVuhXgTqU8V24kQyZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

http://kisskb.ellerman.id.au/kisskb/buildresult/12358024/

/bin/sh: 1: lzop: not found
cat: write error: Broken pipe
make[3]: *** [arch/arm/boot/compressed/piggy.lzo] Error 1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
